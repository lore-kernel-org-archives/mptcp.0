Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA02877E9
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672182; cv=none; b=VGogioWpfnIsXNRGSSgYJvo/Nnufg7rssvV0LSJSnlHtsx92fV7fEJCAuBL64KJLLGGoD4AjO0dWNbXCscWNX3xBMG59esR9IjXCgD8HjLA4Kkr0EpWKvKbRmvwrgciUz9TgiNqJWm6DiYhUlMTDMAFd9Fyrfu+cgsw76vwyuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672182; c=relaxed/simple;
	bh=XUQHncIRf1t3YM9bqUYMsuvhtrte6zaR3u02puf4nZE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rg0L7MI2Z6vYCk8WIiF4JRYdhsk4pCtcj2nYYgvaRcP8dRsEKUIKiuE0MUXMrJPQRrpfwmnvUzb4WNLDM+JgKDClniGzj2D73MOfKNwi7r1zi8+LpNjx3ScJsUWFT8/epJrG5K4P3ZkQgJ/aDUB54KqUGnaXLc/Vv+pXMeONEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrcV1bY2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrcV1bY2"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e699c5b110so239460285a.1
        for <mptcp@lists.linux.dev>; Fri, 08 Aug 2025 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754672179; x=1755276979; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYtIOTG/AAL/Y6+7EhIz4Gvdusby7AftrPt8Leyo0QQ=;
        b=VrcV1bY2BOlxfsaDGp7xU2oDqMrLcx8KPp1FiRfJ9HdR6kvU4BhGny7wcQV/XnyOdG
         m78IWYiQaGs9Z2gTrWXJn30cedz97CROr7JCWa+sxw8pAbB30OTsLGfIhHX3H9NqhIUs
         twxkfDre5nWJsLzYk2oHLBosCa4rpxakUOj7YNmPOTdvdi2Ryly6KVXsQ3Ux0f6iXzHf
         +ljheVU+7WTvdghFTiCvDoQif1heLEKHIL6URS4IfGvQgoCCdKExZcBJ1L8zuWxyBwOf
         lxdIiVrkVc7x7WIEQt7FC3o6DiB63qmRufDjDiqtcA1E3+gIv/jHXzvOZRpzcClKSuF4
         2axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754672179; x=1755276979;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYtIOTG/AAL/Y6+7EhIz4Gvdusby7AftrPt8Leyo0QQ=;
        b=tVpbpmwZx0V2AOVuD3kWdV7+0u/Xg5aHMAZDM+zpOQyMzh9OQVgiXywHj8gtb4BGf2
         0R3p2t1L9D7qmrlkASuS5bN2PHuq+67GjVc5NLphLXSrkLymmf9YX2lxv93moopBx4xv
         NhJuMCuWbBcoipuQjlE1+PF+5+SiOsVuk6R2SXlVQBWTJ3RITDcUxiFIEmSk+0CBQY+p
         KpK13TrdUHRaLcTCI2tXJgDTNk6WbF9yuTBfkXJ7IupxIU/G4gibLx4auEkh0B7vUot/
         4QLlTCuv7GyGG/R+bDztvdIMNzChpqgqMAmiSEObxZ/OMXzhZy6WQZWLRNbMvcmrTwjE
         gb3A==
X-Gm-Message-State: AOJu0Yxhm1qaWXofUkw6QTWmvxz6cS1sv4p6Dlq4aDLDUS8kmEQSg/aw
	N5rRPNURkHiW+TBU+lVP2JrUIQ/+skxNQJW7GNduh7unXFsSBHlSZXgf6iMpaiA=
X-Gm-Gg: ASbGncs7EBrCFMGhILTWRGcSy1DpgVMtOuMy7KDoJnwzXzNhA1SfZvU4eceuNLHeesH
	zC4FzVoKltZm/uPvJwZJs062nCoTK7aUgFHj7lVaHEzyvBcnHg98T+gpatyfh4Leh0gbAefY1gc
	XzN6ukgg0WLoOaWnJNWtVv1CHtLrJPhTDLazlFjHOcrHvaex3Q0gcLf3Zied/IRknWgYD+VIXbt
	HeiNrqqbnC99Qh+4O1EeLVOQSOPzFqBWQ8qfqZL2zzPmI0YAng8fMPH3nDGzFST2YZsofEERTbv
	yyr3N5ivNgCNimxd6fYh9Rw6NcAfzGzcgp9G9wneQuAsQH0F51JbT6jSiyCnuYrrZFFsdJBJbz+
	rmxPl/zY4Im8P0oe1SnxD/M5tI/cVM/0Z7skY
X-Google-Smtp-Source: AGHT+IE0gQlYDUl4LqfSxqpsTuzLk7wwsebYGzPeoPMg9/g+hi/NKoJ/0DRygnK6KBoXkQcbJGPq9w==
X-Received: by 2002:a05:620a:2915:b0:7e3:4428:541e with SMTP id af79cd13be357-7e81ffe78damr1183329385a.30.1754672179448;
        Fri, 08 Aug 2025 09:56:19 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.116.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82a1ccbfesm203041985a.51.2025.08.08.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 09:56:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/9] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <5dfe7378-da92-44a5-bc17-47e6a600f7f9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Aug 2025 16:56:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/168337=
09978

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0c4c63719933
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D989429


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
