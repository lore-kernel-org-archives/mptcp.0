Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23F7C
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 04:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0783C433D6;
	Fri,  2 Dec 2022 04:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669954195;
	bh=ubGorkvnG+fYZfKO1MSu0Vq8vrdN0JsKpKNkn8zefrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mHBAPqLl/Oza2xOH739Dl2vFx5vT8VyCe0yr+iGFmkZI8X78b978HHrZLZlcCX+DT
	 0KdmXfH3lbDu+IjDZt9afeg1xJ7NKILzn7mYQL+aMV96FiUYAqSvsI14Z8FbRKu9ka
	 51CAztn8kq7vet+cKpx/s1Wru6vj4011GrvtyQRM1rVG1IlsOPpY7YqiaFvjLpGVP9
	 MnEBAoW5ym04KItdqMi5/EVqoLYm28/2h5rzN+W3EgpKolWueoe5yIgmGmE1E427cN
	 AIOgJjsOW5wnB1vG/hRovMWvor9f1QCddCBFp8nErni9iuJ76Z9u6VVNGfbOiRTlju
	 ssBVWJeTgxPDw==
Date: Thu, 1 Dec 2022 20:09:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/11] mptcp: PM listener events + selftests
 cleanup
Message-ID: <20221201200953.2944415e@kernel.org>
In-Reply-To: <20221130140637.409926-1-matthieu.baerts@tessares.net>
References: <20221130140637.409926-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Nov 2022 15:06:22 +0100 Matthieu Baerts wrote:
> Thanks to the patch 6/11, the MPTCP path manager now sends Netlink events when
> MPTCP listening sockets are created and closed. The reason why it is needed is
> explained in the linked ticket [1]:
> 
>   MPTCP for Linux, when not using the in-kernel PM, depends on the userspace PM
>   to create extra listening sockets before announcing addresses and ports. Let's
>   call these "PM listeners".
> 
>   With the existing MPTCP netlink events, a userspace PM can create PM listeners
>   at startup time, or in response to an incoming connection. Creating sockets in
>   response to connections is not optimal: ADD_ADDRs can't be sent until the
>   sockets are created and listen()ed, and if all connections are closed then it
>   may not be clear to the userspace PM daemon that PM listener sockets should be
>   cleaned up.
> 
>   Hence this feature request: to add MPTCP netlink events for listening socket
>   close & create, so PM listening sockets can be managed based on application
>   activity.
> 
>   [1] https://github.com/multipath-tcp/mptcp_net-next/issues/313
> 
> Selftests for these new Netlink events have been added in patches 9,11/11.
> 
> The remaining patches introduce different cleanups and small improvements in
> MPTCP selftests to ease the maintenance and the addition of new tests.

Also could you warp you cover letters at 72 characters?
I need to reflow them before I can read them :(
