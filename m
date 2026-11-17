Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955271;
	b=GLL+cIhrERj9quFgVTrsofJeoAfFfKlNvdqrvyJ2DI7mAAurh2auvoNqtytNTFM4tudn
	 M8viEwzyHIWEC/ngT1eTXNATcCvXTSWn/HdUbOK45m8e/WA3gz/+LlWjfxarvdlKsZvu3
	 2LVUT3PVr1Q7cRhHp+qSJEI8ul9Kia3uNYo+fhhosyaYEmdLhpqkb7lEM2UkmMWN4phDT
	 WtMLwQvqbH5EENwVjGDtNd+YTupSeMkfo5vS80DHSSzYBwOG/YqyJscMvmn3ydYsyw4hs
	 eVehzq3snM5HWZdqQqt3WKln275YFXdsi7U9/tmAGQB7ME6LFlKs50tuPHhSRcEjeKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955271;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mntSLj8mnvBuXCjyXeJgHaIqqdgUouJ+FaJVz3u3yg0=;
	b=wIm7oljOzU1Wn1/O57FST4q8DBwFOT+2oEnAPODbHyuGambMU3tUQQcvUu9aXgAGQB9b
	 Fktz5Ku65Dd6/FT0TTY5jxTC8N/fIawd8NI5N5t1Aqb7LBRsilM8jAwtXzolmzDqCzUlT
	 cu0EegDiTMOXgZy9kEZQs4Ksdk8VSfxU6x3zxrCxcjyrsmaW/wWCiXoO/Of3+T5RA8p7/
	 q45FGTV5Sjcbh1jYVPFwrjeyJRL951rCK18dl2Bbwvc6eieRNAh+PFRszytt4wRf72GJe
	 Gxd5MgL+LdBw0f7X9X0yoXnHVcw6+WXMVjBT/1L4CmkTwj4af4TAeCCvI+7JOz0qlBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsdZo2yz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF32606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsdZo2yz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91041F000C7;
	Tue, 17 Nov 2026 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955271;
	bh=mntSLj8mnvBuXCjyXeJgHaIqqdgUouJ+FaJVz3u3yg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NsdZo2yzTNOnLo07VV4lj5G3lQvGthbT8q51ZeMJLh2OgswO8ZwYzICGGZ2iy/Ve6
	 +sZK69p6FSg1Yiw21ioeUE2ShC0bdvOt1vUsF+ATiKjWSMCEsNLWIoqNNtioNH47mt
	 e52HoCGSetOEj11QVtOULDDP3i7FtOVGfGa0RZefq0z6EKlJQRgt15KauM6vjY1Ug/
	 RvJgMG0qObFYKQe6AdLwImrwwLi9ueiwH1F2BIAPzUAAeqBJbmTeNvxtGe4EMTfdsm
	 vFghiHyHR2qeEohKfG4ChYxXjBE0asrILTQdW6rEh/q1VHrPx8EkiEACCn0U7itaW+
	 nrsvCLluQP5EQ==
Subject: Re: [PATCH mptcp-next v28 02/11] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:10 +0000
Message-ID: <179495527047.3133.8487046866212562258@kernel.org>
In-Reply-To: <b10fc6fab784ca954d079569f58ed19155961e5d.1794810809.git.tanggeliang@kylinos.cn>
References: <b10fc6fab784ca954d079569f58ed19155961e5d.1794810809.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In do_recvmsg_cmsg()
  (tools/testing/selftests/net/mptcp/mptcp_connect.c, lines 578-582),…

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This commit adds a SIOCINQ check to mptcp_connect's server mode when
MPTFO is enabled. Before it checks whether SIOCINQ returns INT_MAX, it
waits for MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED. It also adds a new
expect_eof branch to do_recvmsg_cmsg() for the new inq semantics.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..3ae018a2a2155 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -571,6 +575,10 @@ static ssize_t do_recvmsg_cmsg(const int fd, char *buf, const size_t len)
>  			} else {
>  				tcp_inq.expect_eof = true;
>  			}
> +		} else if ((size_t)ret < len &&
> +			   last_hint == (unsigned int)ret &&
> +			   tcp_inq.last == 0) {
> +			tcp_inq.expect_eof = true;
>  		}
>  	}
>  

[Severity: Medium]
Can this new branch in do_recvmsg_cmsg() mark a live connection as
finished?

The companion kernel change ("mptcp: fix TFO SIOCINQ overflow in
mptcp_inq_hint") makes mptcp_inq_hint() report 1, not 0, for an empty
queue at EOF:

net/mptcp/protocol.c:mptcp_inq_hint() {
    ...
	if (!hint_val &&
	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
		return 1;

	return (unsigned int)hint_val;
}

So a post-read hint of 0 only means the receive queue was drained while
the connection is still open. The in-tree mptcp_inq.c test relies on the
same rule in process_one_client():

	/* tcp_inq should be 1 due to received fin. */
	assert(tcp_inq == 1);

do_rnd_read() picks its read size with cap = rand() & 0xffff. That
makes this sequence look possible:

read A: cap is smaller than the queued data, X bytes stay queued,
        tcp_inq.last = X
read B: cap > X, recvmsg() returns exactly X, no new data has arrived,
        hint is 0
        -> tcp_inq.expect_eof = true
read C: the peer's next chunk arrives, recvmsg() returns > 0
        -> xerror("expected EOF, last_hint %u, now %u\n", ...)

mptcp_sockopt.sh runs mptcp_connect with -r 20 and
-c TIMESTAMPNS,TCPINQ. In that mode do_rnd_write() sends 20-byte chunks
and sleeps 200ms after each one, so the receiver often drains the queue
before more data arrives.

Could this make the test fail now and then, even though the kernel
behaves correctly? Before this patch, that state matched neither branch
and the test passed.

Is the new branch needed at all? After DATA_FIN, reading the last bytes
leaves a post-read hint of 1. If DATA_FIN has not been processed yet,
the hint is 0. The existing EOF check already accepts both cases:

	if (ret == 0 && cfg_cmsg_types.tcp_inq)
		if (last_hint != 1 && last_hint != 0)
			xerror("EOF but last tcp_inq hint was %u\n", last_hint);

The commit message also says:

    Add MPTCP expect_eof branch in do_recvmsg_cmsg() for new inq semantics:
    set expect_eof when short read consumes exactly last_hint bytes and
    tcp_inq.last becomes 0.

Nothing limits the branch to MPTCP sockets. Its premise, that a hint of
0 means EOF, also doesn't match mptcp_inq_hint().

No later patch in the series touches mptcp_connect.c, so this branch is
still there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
