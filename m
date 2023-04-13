Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2F7E
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 14:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F5C433D2;
	Thu, 13 Apr 2023 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681397116;
	bh=sX0ILxKB40aVIHVtanZ71F6ffVCczqDh1NoDUTg9TcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oOI3GROGSv+NZ9aIpTgQ5QONb+xK3/SN9ZkKPY55I8keVqio62umJtoqKXdlCzHIm
	 MumhHzUphie1wGydfLT4ePGgiprxHfJxMZYuaOGsANhT58IjSP4ksMWSkyTuGZMhL2
	 XYjrZ7vF1h6uXjIkJdkiGRUbSgRmkwyglwKf0Xs4FjLOTrO8vTm5et4Suyq9AUAf5t
	 MA4Crm9Sh78uJ5Y8xx7sVxXFk4wg+MQ20l8/0J3bAz8DcpaZ06XXUnYHN0T8UbZ2Wx
	 HRXqFysIJ2Fkl9Zk7V6XCFF+giS9tmMvLKS9ilttzgC11ddB3zJKu43urhBJNJ2tva
	 jewCP/Q3+bZPg==
Date: Thu, 13 Apr 2023 07:45:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, David
 Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org, asml.silence@gmail.com,
 leit@fb.com, edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 dccp@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 matthieu.baerts@tessares.net, marcelo.leitner@gmail.com
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Message-ID: <20230413074514.79cc036e@kernel.org>
In-Reply-To: <6438109fe8733_13361929472@willemb.c.googlers.com.notmuch>
References: <75e3c434-eb8b-66e5-5768-ca0f906979a1@kernel.org>
	<67831406-8d2f-feff-f56b-d0f002a95d96@kernel.dk>
	<643573df81e20_11117c2942@willemb.c.googlers.com.notmuch>
	<036c80e5-4844-5c84-304c-7e553fe17a9b@kernel.dk>
	<64357608c396d_113ebd294ba@willemb.c.googlers.com.notmuch>
	<19c69021-dce3-1a4a-00eb-920d1f404cfc@kernel.dk>
	<64357bb97fb19_114b22294c4@willemb.c.googlers.com.notmuch>
	<20cb4641-c765-e5ef-41cb-252be7721ce5@kernel.dk>
	<ZDa32u9RNI4NQ7Ko@gmail.com>
	<6436c01979c9b_163b6294b4@willemb.c.googlers.com.notmuch>
	<ZDdGl/JGDoRDL8ja@gmail.com>
	<6438109fe8733_13361929472@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Apr 2023 10:24:31 -0400 Willem de Bruijn wrote:
> Probably also relevant is whether/how the approach can be extended
> to [gs]etsockopt, as that was another example given, with the same
> challenge.

I had the same thought, given BPF filtering/integration with *etsockopt
is repeatedly giving us grief.
The only lesson from that I can think of is that we should perhaps
suffer thru the one-by-one conversions for a while. Pulling the cases
we inspected out into common code, rather than hope we can cover
everything in one fell swoop.
