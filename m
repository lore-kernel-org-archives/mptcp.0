Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1F3515CE
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457247; cv=none; b=O17VcMniITChJzFAAC/vv0d1eUdWkUWao8GAh3revY4sYPl9JvKYNEvxqTy3ysn3yallDuwri4Sm7lbuG6dE+YP1PyF1bDDnDLZOPY8t4hy996ANygOsBQOj9T2374MhJEXhyUHlcKNMC/uapNB/3EQftR5SmktK7n9mbdfqIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457247; c=relaxed/simple;
	bh=tO5wWXqdrAUdIbyH+6ZodCc/QR5kPpHLYGolV2Wl0S4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=QJVRUPpiBmqohJzEdis7a1r8LqazsI21x0qqKYLBWrgcszZv7FYgSyITYaA+nFUw9v3DQ+oaGYqf8erMQzzn4FzdoCbe5wk8XxY1qjTODHxj8uYqx3DcOJJH4id2uXzmFGdqclu9NLNqNxjM0TUKZRMQN62zvTYUrF4vvZQsteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlq5Ti3W; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlq5Ti3W"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a4a7eb86a4so2075617a91.3
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791457245; x=1792062045; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R362wLWWkB3vB373xgs8nMCT6qLFl0dE74nmFytT8CM=;
        b=jlq5Ti3WigWBizF/udbLryt+/Uwrx8jLrtwlOcf2DlXt1BMnVxb7WYKou7D+qW9ls9
         +I9WLTt2Ghib7E1wPd+c8AxlZzmdntU5ZcI7zH22+92W5dTLu+Oayr9yamBrUVV587SY
         HUFWNDOFGUFw/T9F3qKEq8ulo2dxOt93MEZUOwk0AYSOkvGQ1Ag4xXGg3EMbKr3QkuWG
         9JmRzqU4LqexErJ3Nj73adA5hU0PricQGRkLk4BMemoo3E3vKScoKuhAvngOzy/2b24L
         Rnb4HGaVQ0yZrcDaolQr+7h+hjrO0kyP4Vq5+dGXibxuILzwADhoXBtmKUVIA+bDI54h
         gzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457245; x=1792062045;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R362wLWWkB3vB373xgs8nMCT6qLFl0dE74nmFytT8CM=;
        b=k8TWgXl/MCydDjL4bFM9GknxXWO6cT/9xMLWD7x0YLufwRdg3/Fa2xhARt4mVLa+jc
         ka0mID+Ax9nztiRaOj1ebLjmTp4t9DHH5MjcYgtglBCMFKyikfrmK3VqH1q8k3j2wkmT
         4YcvaCHOoTA54Ntww9s29HxdWCirfQ/ku4qsHgGoWdjMwxG3XF99X5YxxJHO9hlVNv2y
         UY8IGcn6dhNDICWTnup0j5M4+vJ11opXJd24BtHY+15+8H5WeQ4Vzf00mzgaYXdigowv
         ijTYQ44ruVME/ED+Mv9Q5K1LTGIympreiDgnBIrlsnb8AoGC+QvmKPWhrpPtGEy0+mnt
         /Nbg==
X-Gm-Message-State: AFq9FYKi2i1K2P4RTbK9J6w765yWdzmjr21WCPTeq0yNSyUxHVdJo7VX
	kDt8DPT0y+3PSxD9YC+4nXDHFqY+mr2K5JsLiDsxuR/V4MTepulltpYjakxj
X-Gm-Gg: AYBFou3E/lNFvypZp9cR0lLfpJRexauqmDe6OxY2ekENxskAsNXPsHH2KVleSZwrl2d
	vuP9LNl6XCHhk6YIvqsoCo5I91FctTOmiXdWLNqiVzre7AdubvXimSDcFbbqKUkP+JBTK/nam94
	O3NAgppqezt2zRdL8A285JX2kavYZXHrT6pnv9lt4SlILUq/qYg702MsSJr3aP5N5KmWkOcRVLC
	m559zSgYBNdT66Tg4Haxwch2TFIlOXhjOX9HRBOKZ1UQf3+kf3XD6S4akljsjj03Vt4McUgC6mQ
	C/uLGeIJNX5iOgXkgR7iAad5C0RJY9bKqYp/faW50HD4kfqAsC/SpbYlmaftcZxrPe2SjrZvMqq
	1fotpkfiqb/AawfGNZzS8an07ebC+sEmvsEa9kwlRPdD+nK2B1lVKU8DN4r9yPWyt4fPaJG1SEo
	Na0e0rfupXbtHfc/N6Y+CmarbuhmeN20Tn2KrgqtMdj2RvlkxKSj8SC9jISd0+3sAeYd32+03mb
	k9R0IkxfLfHWw==
X-Received: by 2002:a17:90a:d445:b0:3a8:6045:5a2e with SMTP id 98e67ed59e1d1-3a8a1b070a0mr3608295a91.40.1791457245141;
        Thu, 08 Oct 2026 04:00:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.228.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff848f9csm3673528a91.9.2026.10.08.04.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:00:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008-mptcp_nft_version-v1-1-efe5f200cb02@kylinos.cn>
References: <20261008-mptcp_nft_version-v1-1-efe5f200cb02@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: verify nft JSON support
Message-ID: <67f3e227-3621-c5a3-6bf9-a24c747c81fa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:00:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

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
et-next/actions/runs/37761677185

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4b8f2b3674=
88
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181524


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
