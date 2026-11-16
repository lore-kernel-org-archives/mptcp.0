Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841114;
	b=wQ/llRqDyThVYe8VUIhp1ptWDGaQnsM+cXBaeYRrjDP2K/UMsi/3CX1LqFuIppzTNXLO
	 MjQrdmCVyFGy2McOYCbNS4i2dQmHweo0wRoeWSLZ1Agz4UO5vQx4hVf/G8Fr6Jk72CcOh
	 CxT6R+kMXJKeLVkvrzeqsn8dqft2+oZZrlXEfCkIqUdDxS5+g6fAC8QN3p5mMNPMcelP/
	 OiK6vChKW+cJnpPiBcU0stca8kemKjtpjNFYrCMBdRh/TkRmno2DDmuEDaw7jo2ld8tSw
	 dW2ULUy2WbU+QzTU1VEWEt/AO2bza5HUtudqGxysMWXsHJHrgQxaHRtY7rPqBcOSyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841114;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=Uy9Jdn7rHshegnnAyKS/HqBRnthchAJC4iehP0NQYws=;
	b=FA4chB8yHQmmm6o8RojTNZtEzYxb66qIJBrrVjSW+yp9PY/g/GcFI1u7gyi5GfPsDvof
	 aZ16PTyWDpuiEsqARwxitbrHdaz6KlZ5eBIxkyyDxVYesxSn5/iGPlGNtnGIz6jzERc/4
	 ZwKVH9L8U6tahAi3XbDfQbfQw6KWzSc7ikI2/Z+opqqJlx4/th5+YuEw59oyGKSqISUNS
	 LTCcc7RDVmZLXgM16bGoyYtm9ihv4D9suf9o14InVv7kej6qYc1S3EIZaxUl/rVPItQSk
	 sLI840SWtd0CLoVlcPPYFDyK+XfR79yWfZPsO8E6LekhbOb1M4nR9J/TQcb8ezi2F/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="xPyiu6U/";
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF5606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 14:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1FF5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xPyiu6U/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794841107; bh=Uy9Jdn7rHshegnnAyKS/HqBRnthchAJC4iehP0NQYws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xPyiu6U/ezAhtobXj5TzROOPTG3diexHqVgKVOUmvV4TmHaMCOyD5ozVHO6FMGfTp
	 vRdmpV58utbbWQTJ9Y9mIJVRTCAwEADArp6SiOGybEAwfn5LZpQZPArFRTJWmV4TdO
	 ctgkT1sQuQXlUdZaqAhU56giOmCOsgq7sxO3sRjQ=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:2979:aa1c:9ec4:8698])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id E96286B1; Mon, 16 Nov 2026 22:58:22 +0800
X-QQ-mid: xmsmtpt1794841102t6r8bc3kf
Message-ID: <tencent_5497455DD4DAF310EB3F8121517EE9A69B0A@qq.com>
X-QQ-XMAILINFO: M5g+bqkaOkZD92jABezB/5b/8BgAI0UxkFinwmlwcm1KMAW0IqCQlcBXdRq9bw
	 62pW9W2/M48jfxvJXuO14RlFm1CWNIC9tokp/rZekYPIaC4Rs/YcUgNmxszg7NbS7ZvBGTefF2yC
	 xzlpcnn0bb6JjV5SCLxYEQpemGg9BEQ8N+JX9DBVV2Yx0Yi8RoKzJa9L6C+1a/1eDv7cIvC4fDQe
	 OFIhBIi+eoshao5gVX0o+cJ2vz2DRrQl80ep5oPkERphmLzk+GLoJkTjwOuNe7dQULDWNbeGei4o
	 txU9TMtTzJ2nsGlX74o0UhrAh7mQUBOAv4v2ZNBC0SVF5QVnH2tkU0VbRjB/921NwnQxyPvZw0Fh
	 KWnqKT9vFihyhTzhrOcyR8hWOo9Yg/npInzw74Yxlolh8F9PCZc8gcU5We/6L1BkEVwnR4KQYg76
	 QVqm99V88lQdube3fTOLdTWeF4dIhyfd4LG0VaElgjhQgW0KcxbFnvKAEDKR4KJXiUb3G7eaBahX
	 /ThmYvNidNGg1heoG8lLkhoEm8aNe8dm4YWfigK8JJ/owofAuN5mDMde1xqtcckiXp25A658liRL
	 IxN0yf4CHFT/irS7JgHZ2EhgC0FcMwUonCEC6msxy4P00RWUTqPJXLhaFSzUahv99c4cA9obh53l
	 ph14Fi3xBvCkx1DMSldexVvuIsjTa7mHaZBP7eW1rEjk6qMDTjUhRvCQnoKvgnkoduKTXH0TDZ9V
	 dEVU1DkN2KdbOsD8/tgFhaMzyKQ/anF6kkYKfK2+AWShdpIQi0uEYi4HngismnTyZrJnO82Jj+xQ
	 OLODqeFp2Jyr0XL7SSJNguQYmFa08V/wiKsvUQn94GU6j8jS+TVa05xg0yJnYGBwQxdX/e3IMMWL
	 i+UlCKePhvXa1iMkDagJYVjeULPKol00DBGX8vmEqeN1XzSIxhp1q7J6TyFY+0HxTV2ZKW+PDqP3
	 ZxQlD0xL8TER2DEW1pptOqqp7ZvrJJND93AxX++CjSpSFtgNNdkOhFKVy8aUikP/MjRnR4HuU0ri
	 O76g71RCtsAqkJJygE2gCnuXIcX77zOLKPBvHj7fpW4KZBpGi/HJ+qOK+idPE4+MIObN6kf8HcpU
	 oCHoj7QI6WuKoNFAfm+hueghwc65I/310Snvm4vsr+nXdiLFo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Hang Nan <2122295973@qq.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net v4 0/3] mptcp token hash ordering and token 0 lookups
Date: Mon, 16 Nov 2026 22:58:20 +0800
X-OQ-MSGID: <179484110033.96825.12925688433349630389@qq.com>
In-Reply-To: <20261115155747.178858-1-2122295973@qq.com>
References: <20261115155747.178858-1-2122295973@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thanks.  The missing information is now in the cover letter of v5, which I
am posting for a different reason as well (a new KUnit case, see below),
so this is not a repost just to answer this mail.

Short version, per patch:

1/3 acquire ordering: theoretical.  No syzbot report, no KCSAN splat, no
    reproducer.  KCSAN cannot observe it (it does not model reordering of
    marked accesses), and on x86-64 both variants compile to the same
    lock cmpxchg, so there is nothing to observe on that hardware.  The
    evidence is instruction level: on arm64 the CAS becomes CASA.

2/3 token 0: theoretical, found by static analysis.  It now carries a
    KUnit case, which is the closest thing to a trigger that exists
    without winning the race: the test builds the state a dying or
    freshly allocated socket presents to a reader (hashed in bucket 0,
    carrying token 0) and asserts that the lookup does not return it.

      # Subtest: mptcp-token
      ok 1 mptcp_token_test_req_basic
      ok 2 mptcp_token_test_msk_basic
      ok 3 mptcp_token_test_accept
      ok 4 mptcp_token_test_destroyed
      ok 5 mptcp_token_test_zero
      # mptcp-token: pass:5 fail:0 skip:0 total:5

    With the guard reverted, the same kernel reports

      # mptcp_token_test_zero: EXPECTATION FAILED at net/mptcp/token_test.c:1=
80
      not ok 5 mptcp_token_test_zero
      # mptcp-token: pass:4 fail:1 skip:0 total:5

    so the case does fail without the fix; it is not a test that passes
    either way.

3/3 iterator slot check: theoretical as well, and the consumers are
    netlink paths that need privileges in the target network namespace.

Both runs are a defconfig x86-64 kernel with CONFIG_MPTCP=3Dy and
CONFIG_MPTCP_KUNIT_TEST=3Dy, booted under qemu with
kunit.filter_glob=3Dmptcp-token.

