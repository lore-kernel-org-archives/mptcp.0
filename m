Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45C3FFF94
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166102; cv=none; b=CQctqWCs7spNiRPT6kWKqUpyHwmVFy+K/B9o3BW7w6BOUnqH9gdGrvr/IaCyLl6Z27pQ8VYPb/XSmlAvqEKYaR3jxXaLej+3nWUP5sQXVSZ+mcyGNCF6estuPu98BCMImm1fPOT8pHSzm4yYhxEEhElbI1ew5lyl/QIEkLf53gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166102; c=relaxed/simple;
	bh=k1RmcUGNLF8fdtopH8u6aqf0Vl8uuREgAtPkaKJHnFI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=VRABWUsVKDkMXdcZCcJpFPkySrMDpMWIqHHeYVyZKax+Xni4H7oU5wZDi8W4VfkP8J2C4qxuQHSxHglH+7SQ40NBK8uLPl0AlavHbDRDbyIDfqlD6KsQWWItDCH23ZO04vqMZV/wf5z66XhwxM3aoVUS3OePhFbWT9BgZ4KfcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVaclDo1; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVaclDo1"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4c5b53d710cso617072b6e.2
        for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790166100; x=1790770900; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CC2AzYi4qL/2AmwB05EUqjUgn8rIxa0yAyd7YXQylpc=;
        b=DVaclDo1GkxCzFHxcqkjtQENOqKPYQvbOQlMXKwO12kFOKps6XP2WnlGPGL/1xBXdw
         bOsBkYGYijO9NNRCXPfOpeu1KWl073O+06Rqd/+dztqGSp60z0bYyXtei8FnYiuxzoHp
         YqqFBn79xYcTjG/T4Fd4BgB2M3r9YpUJu+U4oHMQn/Kn7t+J4f8fNu+0CYI4uSxYQaLR
         u6hR+NXSv4hEJ0YkpDD/3yP8NnKuWsVObkm8RTMG2rVQD/5hpsDtz4vHgjgfpNIgWXtp
         /mxvwUx6wgzJz1wJ5VoXz/cnXNUApDlahIgCxlLLkqg/RRZbk1h0z3re6x+WL0VMGqaz
         xUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166100; x=1790770900;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CC2AzYi4qL/2AmwB05EUqjUgn8rIxa0yAyd7YXQylpc=;
        b=c0FyLck5KDSHNUTW8vzdzkbCpMC/zkd+AEjDWyHm+2l7TS5f3m2idyiu6bu2pTknk/
         AKVKZyxQN8pURIusJAWDy/Nf6K3kCLAGXK8eFvIN4EOYwdf19B7iXeHVXjtfqsJEYDcG
         PHGmIsv1z/2tfSbl7832nTXKfMy7JIpdVu7NxNhxLJlnUOyJMNYKOexCNY4h2ynPg6lK
         QqdW+iuvcYqZ9YsbO+EphyQHzDcJAdgGWo7lkPu0nl5ZbVVf8dD3Jkz/DPrDqlu6gcph
         nVX57+VLoxAuJuBZbF34i5w2hg4HDJvczd58K9yXs0oO8ksK4gKjH/u9NWmYb8d4tVii
         CLdQ==
X-Gm-Message-State: AFuF++kQFeqt8theOTeq0FUV3A/QEQuPUNepxCut44jSWLCjoZILCGYD
	DCzh7QJwwXEhZMXwVwshGs2yZoHZVfpSJVd9FZB0wNS5AONOXeq9d41fEZvx
X-Gm-Gg: AYBFou2VxwX1eY25MOs4GnftOb6q6408KCnl0w0Pm+ZTLcXloEE8wKy8q1IYnGm4Vhj
	YpA/Fvoh69xZBl3TiY8baAgpG9Q2XJo8hIa2GVpXSRMe+OD1f7FHEyEX8cBvlbhm2Y8kUwmp2Tb
	UDcSPPLb1V4KUb0CWwqMnm6JCJsSl2ZpJ2vcN+PGNVD1Y777ZTjAkwe7d5QkanYJIwgnKMyycBa
	GBM3+pPBguBNrk9WUYrE12oNYr55Lxdca6BiSHIEpIfO+D6xwqltJ0BPOOP+mlcm7SsrB62ULp6
	qCCEwczN7AvwbQ0L/Sa+arjRpVdJlEMTa+Noy1Jh+6VCx+8oAO8cIuwbZdA+1MSg1FNqs5RP6Em
	9IQfQqyRjQZ/HIqsdgHl4IHznVHaHdQzgz+7aNNTeoPuE3Hn3N9As9TExUrcrNAQV3p6Hm+RgDq
	8/WCoTwFeFusqzSax8AR/rkP7Z7v+S822+W7P+Wk7sEUBNhm76E2P1gkZ8cS89CyU/F+0gNW/VF
	0tw64vOkJhkCjg=
X-Received: by 2002:a05:6808:f11:b0:4d5:295c:a82f with SMTP id 5614622812f47-4d5b9626111mr1945280b6e.60.1790166100086;
        Wed, 23 Sep 2026 05:21:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.199])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816049b51b2sm2730712a34.22.2026.09.23.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:21:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c859a0153b64833949f03be2391e4d2a60f8d6d.1790160379.git.pabeni@redhat.com>
References:
 <0c859a0153b64833949f03be2391e4d2a60f8d6d.1790160379.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix subflow bitfield misuse
Message-ID: <393d572f-b94d-3f2a-13b1-0b2aecd151cd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 12:21:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35853276088

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/aaacd43ef1=
cc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1172144


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
