defmodule Elixirblog.FeedTest do
  use Elixirblog.DataCase

  alias Elixirblog.Feed

  describe "posts" do
    alias Elixirblog.Feed.Post

    @valid_attrs %{description: "some description", title: "some title", user: "some user"}
    @update_attrs %{description: "some updated description", title: "some updated title", user: "some updated user"}
    @invalid_attrs %{description: nil, title: nil, user: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feed.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Feed.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Feed.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Feed.create_post(@valid_attrs)
      assert post.description == "some description"
      assert post.title == "some title"
      assert post.user == "some user"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feed.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Feed.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.description == "some updated description"
      assert post.title == "some updated title"
      assert post.user == "some updated user"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Feed.update_post(post, @invalid_attrs)
      assert post == Feed.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Feed.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Feed.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Feed.change_post(post)
    end
  end
end
