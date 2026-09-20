Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58C3DD516
	for <mptcp@lists.linux.dev>; Sun, 20 Sep 2026 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889177; cv=none; b=Qq5wfo7fnVowT0qJX3FjTAqSbbLFR70YlTr2nqRo5qXx1JlEyhwXpaPZwAkeFA3/9wjrOSIQ/SCKYjBVAfOpSofJUrhcT/CFxGqU7B/r8xZX6gE/nMCC3f2tF5o4hErkKD1ByXFCEP5kIop0i1aJzwpQ88tN0ci8sJqq3wLdX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889177; c=relaxed/simple;
	bh=MJ/SncBhM6IcmeHcSD5Tm4kLyEl8M2/Se9HoZp+wbN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=VYvAEeQsGE/39Hr4HaL9Vv0pM1PKO/4AZFdC402z5Pl7KvgLK2/b56rjVYFwhyXe5m46ydbBruXPDhoKlq2WjBbvUcDJv4KKnExbv8fKHemuOxKPWsfDOw8V4aiH0o0u4Q7avo1C85H+4CzpXVtyfjZ+sb8AcSv6SDYps0iu0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5w44eN1; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5w44eN1"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df36461d63so4433875ad.3
        for <mptcp@lists.linux.dev>; Sun, 20 Sep 2026 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889175; x=1790493975; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LRqyauZxQgPc7fCQiQFfHzSaKUiVKo7nkfepu3KOJXA=;
        b=Y5w44eN1Zhy1yarDNPcOkRPg2LH8m+1pTv7CuR2T9etlveRTJ+0Fuqj1Llj6xJ2+4n
         t8/4yJJjxHKBNc4RG50tnKPCvxvh15gn8JaQHGYM0sv2+WgL4MeyUgYd/ccZeycaNtL2
         jSmrQckFnVfIHzKejQZHwE+iZTSrkwkmrDy/IyK+TamdNIf6+zC8AF3eUMZffq7VSoob
         2jftL+E54ThAvP9uMFsClng3jxvq/TUo1QWIWt1r7qNVF5hwiyLXfMANx5/AzbOeG2Tg
         LKk0IfWWCODN5TJK1yxhnSICEA0P3Z7ZqsSPhRvu8Gp/jqBFhIcw5NSPc2875FrEnU2i
         utDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889175; x=1790493975;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRqyauZxQgPc7fCQiQFfHzSaKUiVKo7nkfepu3KOJXA=;
        b=UIAXNlii+KWPtILo3ipejMx6QzcRxdaWlQSf87HCvGEdXRGZxVXX9fgbkFzAIaN/r1
         b4vltFBwWtOWDeb0Pa+6d1HZ1gaKEyNUR86Phe6Z3eYOhpmdYSADzzDpIwAjBgY2/2cb
         UclTdEAJ5K7w7dpGwOgSrtQYAg7p2h0zTKxEA3Wrz7N00gu4WDVvKpQ+bzF8mGt10Kc8
         kr2CWp0QzzROxu3wK8hV04B9Ny297CmaXyi7CFFzQm9dZ8ijsxA+V2BT81FYsewqchg5
         7RcyvVe47sPK4pH00YWUMkX4S004zpdARpM9ekEqiq/QDdlB+W9SNkdTBEs84OT4aPeT
         KKNg==
X-Gm-Message-State: AFuF++neUAbAE1BqTYG2LX9LA3LFRC4SBZE6WNMitcdmsfqdPIhn8iZC
	Ka8wQAv62rMUi6LzXK1ZBrZyYO8Ehc0AuaBa//PPhlJuE7TfjEazC4DTheLzD2s=
X-Gm-Gg: AYBFou3oX9W84HuSN32uHu9NgNR4DuS+Jh35G9Kq9rVK8VF0YQSv9TrL7LmyCLVY3xi
	CLkxpJ44Cz616vvPNodqENVAYw/4kYkvIyNws1UTlahPonKmUXkzEJ9dsb2/LpquyRD6ERMLe1Q
	Nz9dHxtgFA0RKD+w8s893s8TPPbmFJcQAwFKpSNhgdRTGs+q/oxlHvfYF2HK2zPNs9Edq1jd58D
	QyeLX8ZG6nrAmNe4i7SCDRM4EXwEoqORsynIDHTMDAyiCHDgNjLdYlnHgfkZm8MmmYs5yS6xg4t
	+PLZ32vFZnJuBOhNrBCbs27281GOJ9d2hFZDnRdAguIFR7kK7D6Vhv2AnjEIY421KwHMERqzyyL
	8wVGPaekkC0W6M35QrxXp54HdXdpXsrFkIevwefh3sHAeXXBCxjiAjcQsGAq+Hm3HP9D+tpb+iI
	KcyKFOf3uKMxI0Mfnok7mXpWZObNNgYpFRnZcgKfb6Tqu7jFM4mqxw3U3vlCfxSiHjgRssZZuX7
	rLXIdqklQ8uXRFVjwgj
X-Received: by 2002:a17:903:1a85:b0:2dd:ad73:c987 with SMTP id d9443c01a7336-2ddb1bbc1bamr107635295ad.31.1789889175381;
        Sun, 20 Sep 2026 00:26:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c33186490sm8951890eec.18.2026.09.20.00.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:26:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260920061904.3575780-1-yilinzhang@moonshot.ai>
References: <20260920061904.3575780-1-yilinzhang@moonshot.ai>
Subject: Re: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
Message-ID: <9e7c2de6-d11c-7947-8c67-e2274f3d0f4d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 07:26:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yilin,

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
et-next/actions/runs/35494716290

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2f1608ef83=
a5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1169618


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
