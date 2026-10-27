Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086733;
	b=3pM+Aj2AxDrXO4/Ytl7QRROITqIGRHinenjZb4XcjAu+XVx0MHobHbrrPoj0yG8gZLjK
	 BdnTVUH0Zmpf0Dopq+T6UzGEDp5CZcy8r1VE9wjtasO/TSyzQYrrTKnzWV/4kkU5eNjTv
	 x/M4EbzBQWeiHzr7cvYbVlp9SoICSUUktbo3pM2ifu+6D+wDWGut9lYsODBuYM4XN56nP
	 xVs7IMvsbo3S6aOSal/+BXhJZ3Ky4PNXZeJQa5XqCMOq3NnXoqYdXaTwHhvchFDIMjFVb
	 NRugyZakMksqyV5aGPvvasHqDGkb5mGHF7ok2ue7tg8hfArtrDBRZqUCnhNMZuM8lXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=STnBXLoyuNVPmD+6wuUSbKBqvU3bd1NjmZVkTvZQi2w=;
	b=X9dVwmy3xRy7hsp45WiFPWO8BeO6c7wXn+2birhPaCF22fWWxW+cQGptPw2YsVUMW524
	 U/M9nMiKnQs6qc70yJlLKyjNaJZ9HbA8OCeG5bV0Ownce6fhhB2RnM+/uQ4BIeAtWzIA8
	 pKsT+b5DGv5+L0fLMa87zlI58IUKEafCQBKJCt/P+g4TCOlzKJ5UxA/nVC3xRO+36EGqC
	 0DPy78hpOdRYidjOnWrnSjPcr10oIRZHeYaI3BfhDha3+pTbxTKu3H3UvZVbPo2cwx1nD
	 KwjUdSqx1ArYpG0pKBRLVL/jCNoc+d1G3/b+UdOuLeGGCE/J4CvKRzKdo1zYIqKWdPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HAqYTu6e;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908F606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 07:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0908F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HAqYTu6e
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e812e2b31bso22928145ad.3
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793086732; x=1793691532; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=STnBXLoyuNVPmD+6wuUSbKBqvU3bd1NjmZVkTvZQi2w=;
        b=HAqYTu6ebrgtWUK+uEQm55nXa2SvW8IUdZk30t/rrMdX67h8S7O0ZclNI6LwqOGPsH
         Xz50tzP9HMbAPbOwYFxSm9g7zceAKcRc6/5CuDc4w8ZW0B6BbsATwHs0DmVn8LOgjoFf
         Z54mJfOAPxrQx5+HSHTtlMuWJo0TX73KWV4I26OKrMh3RXFfS8JyTc8NcISdNVdZvwIh
         WgZK1+2tNHjXNXqmrzRbMCtiUJBqj3FB+24ciyzXN42EPZruCfErxpibT10VRuoNsdOr
         97KfkiMsLS2Rc2RTASIxPpVNhbsZpByGvj3f1UzloXr7DX1XuoVnVTIN6f6ZmgPXt2vX
         X+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086732; x=1793691532;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STnBXLoyuNVPmD+6wuUSbKBqvU3bd1NjmZVkTvZQi2w=;
        b=QzUUN01bHFq9a5+YGBaCjbaPJkSVcc50kv20dSQXGRIL86Avdm2wBcfBKvlM9YuV6W
         luPTSyJioHpuy5+ec+o9tvJlhQfykpHqwK9p8o+MAWj3nSADzYIOekNPDHRhXBpVVhd3
         pp8ad8wDUJ0CWeQlYKVUp8gzoDP8J1DELzw4vRkRppliLZ2Z0ogkyhtwLkluCK6rZwyl
         sT4HAp1gjPMyfaFVnLbrbcEH//hTjNrNeTjKCgBVQuNlGQ1wNST0CaA1ld/+Vk7nANLH
         +8k13mESfoCJB4yiF+GVA0h+AsJ7djlRcV+N4XxSsSrPc797FurHgPIWJoTCqniHqLi0
         glGg==
X-Gm-Message-State: AFq9FYLMQmpF/aBaT90mIvGKFdA6j73ZrzRsRcyuXYsstx1PBbfY4zDT
	bDHtIwoHqxPC6fjxpO5EO6XCB+T4weJMl796mlk5FKm9j2ArAZVsjRc5vTRw02I=
X-Gm-Gg: AYBFou1s0Qd3PggJkUQk5oL8E5d6ympVRUlMWkA8ptmv0GaDrrUq9VvWjAgmLYb9JfT
	0W6fNH1AXl1PdrL8tXRQB63m/xbBejZrVty+1ffD3dfL1pEciewos1qvovuEkKVWkg+5t6WQPn2
	vV1jW95zbiIBk+969dw2xwrWath67ZpC06UIT+MzMIaIyjexMtUSqRWHpvQbKDUoH8qxrkcKwN4
	Tfi1l9PWgGqnR9hRQBznyleTEju4W4nCylEZQSwfKGTzJPkIYwx5noB00rbU46UQaGSlPYRvFse
	ZCWHuXI797kK8okITut3765TDw1Vt4uhWkeA7y+wTVEOsAIkdi5hRTZ/qCGUZy1jFEnv9f5GoyX
	O5WHkdDVBOys1IB8gqe+ObEi0FbL26YM6g8wVYejtyKpLT1aJm4CPeV97AG4bljjm1yq7eXSC1j
	fJhDJSPowrlT4dsDApXjXONXpplQvge1iA661CpXSSVVN91Kj4kXDyOVgN6H16QHIQyLjwbcjT6
	UZ9L4GFeJp3phyWwlGfYYKO/6L9/1ZhSIm7uRPlJxRHv9gpp6si6UPyLN73lebG73Zk
X-Received: by 2002:a17:903:3c6b:b0:2e9:460e:ca49 with SMTP id d9443c01a7336-2ea9c6c290amr81133895ad.18.1793086732097;
        Tue, 27 Oct 2026 00:38:52 -0700 (PDT)
Received: from github.com ([52.250.210.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c37551sm5065395ad.51.2026.10.27.00.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:38:51 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <2420d730-c0e7-458e-7cbb-e196c26c4e5f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 07:38:50 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

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
et-next/actions/runs/40463062491

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/bfa75570ac=
e6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1194301


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
