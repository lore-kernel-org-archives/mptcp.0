Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0501A8F7B
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688321; cv=none; b=O2Y6B7Ifjxtd2YoqOETsu8SRhKNuAVmkNhKP+iXFmN1L5p3xwW0tzTH0dAnB6k/hUowzGwxEHTLhGIkjNADy7DNJI6lsKyaMqZrb12HJ6iOzsNuZna4qRA9YP8Dys6d1nfpjUMz5EkUgR/6DwpveYxafD8bTjTJeNlYocGYJgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688321; c=relaxed/simple;
	bh=KRpcpRBWqW+GpJY9sVnGLyqT2u9qL0n8bO4fYqIYWNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=o+o0O+GCyp01MsFMSWxzwZ3nJNzHhIZpSqTcnCDVRH02CvaH4uE4TWQbtffHe6qR09rrikWthLjbb2I9dyi2rxO89iodm/cEGG65+dfNKr8LH6xiasPetFASMwYlTm9ZTVwLtNV9a+5kueCbe8ZWTzve/Gscr5o+9s6X6wlq4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNroF6JN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNroF6JN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e99ef0902so37417785a.2
        for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 23:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786688319; x=1787293119; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rtRJOoKwYBRTqSxThv0/GVfqJ70RbOQlRiuBvygOeVQ=;
        b=gNroF6JNGyN173+Hwzy1y+mFONHda3C+91wTQ46eC5MuHZtF/efxUj6LZh5V4Kf3jc
         I97LG3WnBaTqv2MBkL/Ckgvj8WRAnDXOHxuRubZjeIBuJZNGHUvtz76oE4wC8Rp2DBjz
         6/7BK5PTCiFQApvXRqEmmBgLhRk11jZPbDOO/Tzo1uLjOFAXrLU1nRJ/7SUofdemU0l8
         lN/DuiVJDSKLg2udqBaAiUt8foK5sjZDw7CvZCiuUUqvfAcl0f1nNc6MzuCT6HH0MMIk
         mYhD5DK+fFZi3T7AJHrmDJjfbH7b2Hs6APhd59dMQHGjzKpo/HRe5tCC8ZDZtlD75LbH
         A6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786688319; x=1787293119;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtRJOoKwYBRTqSxThv0/GVfqJ70RbOQlRiuBvygOeVQ=;
        b=pJn0Dz9/SRG5m51Vr790Nw99lrM7LFHX6CcR3M+vfPdll+NllPBk6QHoyZCfdxwBkV
         Xs2RhV2fyU1TG0+kj2cX9Zk5Pa3OTAi/LlB0s7gs5dl2nvs6FS5y9/ODhK7B/P4HHOBD
         r/HcI5rl5A4x/0JApcW7tD4LHkEQzpGJW9LaxxRBylnnSUMIVVrsjHd6gukypx683oGa
         Eo48YQDr2S88K87La8VyNAy0Ml/k1F2cfMYTRPzAnWy4A57b4PYj9an8d2C7yGDtBPoy
         aCBbKj512PHyLFxH5m0X16CMtIuTe8bk+1mPn+k/7o/R0g4fOF38TI36hzhcRgi5Wn3i
         yCHg==
X-Gm-Message-State: AOJu0YzZ9htuusrjVfyuZv6AkFW3N7BYqFluFa8vvlKxNMsTOq7+mTio
	roe9sIpyvrWA0BfVl657HuMUnfeOGb4HyzwASIiRcO2gFrNMDv4bTAGKaGi0
X-Gm-Gg: AR+sD137PnKHk30+9WxGPOv9SGYXEzdJ1kF8l6nyeKAJRAnSsA649hn+3AKl36/wiU4
	p+qRv0ntq0Es++R9SuUZAgw+9p5mUsbNE+8et/Cl+bB+ytLxMFFoIY3P7WeSfyNKYnL2R57ui33
	kjoo+lkR11thHrWrQSM1BQlvOLrawIRt/SwkA37QHljS+gguPvjhG3JTMrbWcFcwyIwaotPABl3
	x1fVo+JyA7cJlNDTnU90VOJrB249X5Jp2x/OY6dNz+iH98kgUdGtGWnUljzEkxbpnQXmzdzyCjC
	C0aUQfa45qn8SuouEdjqUH23EML9PYiRDz6GVH9KyravhuFLd/0+V4GPq1+Gk1tHfQFZYmjRc/N
	xNKi8HM2RL8dKJDbZNIb8mKwmKBKfngN/IB4a6aGVBOYUzEbRyJQuuS9tzn3rROvmsGXK/NaAYd
	tJta1DZzIY2Ohn367HmHt8UDU7gf1d5uRf8ZEL2Srnlo5JUTKYAI4bxeX6omYPBPVHv7wZ2ox/l
	rbJ5CLIG34=
X-Received: by 2002:a05:620a:17a1:b0:92e:7c7e:9c9a with SMTP id af79cd13be357-936d2361c7dmr313824885a.31.1786688319206;
        Thu, 13 Aug 2026 23:18:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.210.0.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce09742bsm190961485a.15.2026.08.13.23.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 23:18:38 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260814050625.80231-1-gang.yan@linux.dev>
References: <20260814050625.80231-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix an UAF in
 mptcp_connect.c
Message-ID: <a5a8fd2b-716e-75e2-0c13-8b115e6460ef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 06:18:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/317733=
41323

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3c5bc3507f5e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1145826


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
