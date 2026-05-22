Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA8258CE5
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422137; cv=none; b=JaGr4yty1gKyOc2VQYUueWZC1YVYyiUsKlirrsPkz5mGC5QVdTvhYtwhli3PKdRFUefjD6J06ayepCeu4OKomM54I1IhVBkQr6H6/UGQUxzlfp+tLaQaV/vvr2qbdfW4TDzhuZe7Q1FWt8I8niaT+E/vyuKSIPcT79NzKhhZ8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422137; c=relaxed/simple;
	bh=Uj4NYSEzfbv8Ga1+Qfeb4EJX4UTZVsXiMwlUAbz82Sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=NXRDJf7ZfbtMLJJ0u/AP8t8UtUSsMGLBjWOUc3KBtmtyfFRoHHw8HdCNeyz0QdN5dw6FFFtYb8ncXBBshq+m9E+yODorSWmxWAVIpotItd2k2IMdKvhhtiBzbay1TRJ21X/ZzqDKZr0V3nvfl9b/32uVgyDeylBlod0pA5Mwx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjsAAAPY; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjsAAAPY"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f3c623322bso1174531eec.0
        for <mptcp@lists.linux.dev>; Thu, 21 May 2026 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779422135; x=1780026935; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHKabLdBvRJR0UbaMhwG5HDK5XhwGjS+rMMLUE5Z+Rk=;
        b=jjsAAAPYSB69HMJ+DKOd2NJdTR2H8BY0hxEMFvmZRNA+Lpbz8xVmevNRHYJtBsikbQ
         fPUxYdXMYthtfZUSxHApIH4r87UDUfqiRabFwLSntCMpjo7jv/kPhFt3pxgX9VU5CcIT
         okWPDWaG2san7nefp5/LTDHLmBey5vL/xQ5AL5vflqG5+V6XugQ9Q69Meojk05xtYqAO
         KdTiy46JvLUXBqvL9J16IAW5APIMLQmuodrqfpd98vvUVzT8+vBikZEO6h3D1yd1GWWL
         p/OowTlqQh+wagHpqSPOgYp5PnJLs8FmWgpwZsgx5wCQ8IulW2AldXHpkwGLFeBLJmoE
         TMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779422135; x=1780026935;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHKabLdBvRJR0UbaMhwG5HDK5XhwGjS+rMMLUE5Z+Rk=;
        b=AJx4iIXq9WCw+lRJcpyGsxfPU5PpwkYLEazks9DuucwnDjqaaGQ468j73d580PvuSY
         hTLiQ75a+d4+wpoOwGWz0aupt5VL9ljDTIe61k9I6+219Z9ks9lNB5CCInNazVO4CSmP
         E/TZ8KuFaOOzOqDG7zc5UGezWs52wvFPnIwumYLyxiTDqHCm09FrrMcV03NRTbv6j3bC
         qDCv4tQJjmScCgtHgvkct+qy5ctpoD7ejtrXQ2au+5Mkm+wVmRfTQGvMVu0/xeiW5w5X
         RiJz3iPY0o+bhXHz4LLzTf2X6yRe6aV1YxdKyMP/5S26BPFZrr2xOVX0hGiM2Oj38CET
         R7qA==
X-Gm-Message-State: AOJu0YxfS/kfFoLDDzC6gDphZ0M/0kYQNndG+394hmtLr4MB9bBEtaYh
	t1/XNmq+EayVbeQccLy2m3nfffTM0+XsaQAcpOCgu32bO2dTuUDD1ntTUwSi
X-Gm-Gg: Acq92OH4A3APJVZSOAhihXXJ4VIhC7vL+eagb26ROtFoCWsuTPbmrxDDCPuhvNsGpKi
	IhEH4/UumumXfCvTp9L5vg0LKiz2BbFRd5kdt7Vcuk3gFrtE3DZsoEiScqeO7ctCX/C2AGwOe34
	VSQmmz1iLgaRim2HtRt1vV1TxcvZ3oxaEXSbqC6eECRu55XwENvclVCIhZY90UCAr2/k5CzdPh+
	WjPGGNDRZEpMiw8WPD2rPmIE2V7peoN8PbFA0jb93ctlttNrwxlo0Sj1/qZkqkIgjv+GVqfSEAi
	Kp1ugC9SpLosJbkSxNc+W7RlOKOKnsmsKdVu+bc9MkdK8AmISXqDOMTVGcLLEqsySajbCrSiR9/
	+C/j6R/VYnqVCNFkXEJoDYkmH+mr4fAje1QYLcQHPotttEumGzkreqG4qIzVQTEYfFJQnMk3m4Q
	AtB+4fx8hPNYwQaxRaWV03W7cZ6kuhT04+fUOD
X-Received: by 2002:a05:7300:aca6:b0:304:aca:35c5 with SMTP id 5a478bee46e88-30449193062mr918071eec.23.1779422134716;
        Thu, 21 May 2026 20:55:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.244.73])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230b25sm60931eec.15.2026.05.21.20.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 20:55:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779416980.git.tanggeliang@kylinos.cn>
References: <cover.1779416980.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v16 00/12] NVME over MPTCP
Message-ID: <5592368d-a541-fbc0-2d74-9b679495e873@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 03:55:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/262659=
15269

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6d759e90f4b5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1099108


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
