Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09A2F509
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORSyIWU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848F0C433C8;
	Tue,  7 Nov 2023 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699374525;
	bh=7TvfwB7yXJpILaOA7d2Cum2Hm2ExX9GQL29tilHDNtE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ORSyIWU53HbMDOrLWSRi+CPWCfMXPLe+7BfGe6lx1+PXeZvbXWqLCDgnURJ3SrhE/
	 AazVsn63nVb/Jyy+IdYEMqXviSD/lj/vqfe3Ad4/pxh8xIsBtVrILx9FAdGPkcydJI
	 5ezjY2IwHyLhck8qGRZEeSklMgYss56fU9QytWPGQUW8pb9OWobIv92X95prvPIccW
	 5/CjDhM7lseLAtVnr72v79LaiWSQhmBU9b4Hhi+yi3oYJeuqGzPEwbFprQtPKgGD0+
	 LfmeZO7ISyQGWQhC/1QAndnqmUYXckDT4FtjjPkS1g/Z2gwzr/YQet/0nrR7B9vQHR
	 EVe37P9tslgkg==
Date: Tue, 7 Nov 2023 08:28:44 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix possible NULL pointer dereference
 on close
In-Reply-To: <af0b44d9ca35964d3754dc1bd372a423cb695e4a.camel@redhat.com>
Message-ID: <54adde31-c124-752a-c962-d7cc1295434c@kernel.org>
References: <3350eaf14a073538bf491f93fc852cd02ab0875a.1699280113.git.pabeni@redhat.com> <4d50ae35-689b-5223-75c5-1b1845ab6211@kernel.org> <af0b44d9ca35964d3754dc1bd372a423cb695e4a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 7 Nov 2023, Paolo Abeni wrote:

> On Mon, 2023-11-06 at 17:44 -0800, Mat Martineau wrote:
>> This does address the call stack that syzbot triggered. Are you sure
>> enough that the only way to reach __mptcp_set_connected() with msk->first
>> == NULL is when mptcp_set_connected() encountered a locked socket and had
>> to defer the call? It seems like that *should* be the case but it's not
>> obvious to me that it's impossible in every other scenario.
>
> AFAIK, yes. msk->first is freed and the pointer is set to NULL only at
> sk destruction time, by: __mptcp_destroy_sock() -> mptcp_destroy() ->
> mptcp_destroy_common() -> __mptcp_close_ssk()
>
> The commit message intended to point to the above even if a very very
> terse way.
>
> Putting the check in release callback - in an unlikely branch - was
> intentional to avoid unneeded conditional in all the other cases.
>
>
> Please let me know if I should repost with a more verbose commit
> message (and addressing the typo you noticed).
>

Hi Paolo -

Yes, I think a v2 with more specifics would be helpful. Thanks!


Mat

