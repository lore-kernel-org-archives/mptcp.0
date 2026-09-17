Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3724A7C98
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638895; cv=none; b=cYm1zpKL61cXmwmBN9VwM8CTf3jhaQrR88tTI+5FfenJRdNnvs7d8uz8vsDqwbMyy86pWMdMVuieSyOYdTtAHKBKEoq5kBLlFN9iecMteo7TawSuzM1JN6N+7vJ3ahNo2rMgc2dZ5ZdclEf3S8EBciDc0QEtbmDgwVF4aN4tKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638895; c=relaxed/simple;
	bh=PNKj8muQEq2/0lNDDsFxvxPzS19KL0wVE5P67sBibFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RT+qAS0nZhAiDEEoadwSobiPPm7T6Yd1xfZx0dgQv2if2/qgOnB2nWfEYjuxvKi1N0iNY8c6swrwtKGWD/OwnK0oEx9xRhekOgW8TeXdFr37KqqjjnrGdX/SboVEH/kBFPvk7a7gimb3gnh+yB9DsHtyKyCuaofOEf7nJsZrJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssb/vN9B; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssb/vN9B"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ef19aso6168521cf.2
        for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789638874; x=1790243674; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fcV5lInkdj4K9HmcbhNaiKkHhbQrLnSuuNA0NuHlonA=;
        b=ssb/vN9BqeQ1RxPn/iPc0Ggr6W+hP+i8Vz5T/R6ZeourZXnyUvvMlL3q/e5QN8OE3W
         sQ/7177L8oHlwdl18zOhimLAz6Q+2FjbVsvL9yLnOINoRG8buhY52uVLkqj5jSAo9KDK
         SC7WBxsKX9pi+1TbgfrV8cG+FK1xtgxddIRJ/muwBsapX+x9nJVtbiDw5GzZ06/RYYQ4
         gJHUm1JDYGFds1biQ4AgjlzVWsr6vX4bq1uyzH2IN1JhlkAPamMOLevjCuvWoBmOqwiW
         ydliwDTTJRAxyrolNY1arKbWNA24hJZRIRlmd734TXRcUvwJsJEoSaEerLqUFukyoush
         z+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789638874; x=1790243674;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fcV5lInkdj4K9HmcbhNaiKkHhbQrLnSuuNA0NuHlonA=;
        b=mrt0SogQNiONyFhdsoXMX7ZLJRvUPMpqmxdYjs0DLx+nwWCsFjUTSBomS4O4JO73Kl
         CdO9/Dlr8tq18B2S0LywPHDyKcKuRpITipN3uzlNuWB/cADfxEv3koeEdyW3T/9n1bqE
         fXjxoIUt06mSTwh3C1VilLomq1hLxnPV3nz5jquL4UAUTgy5qtQAnm90vmWEwZFFNt/N
         WfZYcOXeZGMIKEUIU1yDm0Jwk01wjx3VlXQdhplzE/gcK5CjAGT+ImbyH3si2wH/npOL
         C6QD8NMEpx5UGcQz/P/IaZhXORCzfyvLRSCZ3caGBeZFg3RBlyORPACnyCtJ4SvX78C0
         p9xw==
X-Gm-Message-State: AFuF++nklf7Z0uBUt2lT5ihVPnzutLrlIr5F6e0hM2TLcvYdpR84tYJU
	QuQ/E2akfqGJQfiTxVxkLCaf52mB8CDpXkOkaoUeyq22xHuhazaJYPJFCG3O
X-Gm-Gg: AYBFou3E7u/4EAcSErevC1muEydOfN0nFIYB70MqxJ3Vxissf1sL9qqWtoNMk8kFRGX
	P/ThaSW0ZwKkgMTwjgqVtxyMyUH3SSzP+gWL30zWPTJLNliFviFcEheQ7uanB/Rp+JLguATGXbr
	g0UyV+xsBoSD3T7IZDtrnFblQE7jwA0Y47vE+gC1qZN5+zdkkPyKVi85vZfws0fjgV7+UW0r7Tw
	Udz2Cy1w0XsWEp1hntRodVnTFLBD45L569ULNKLnibKzcaaR3eKBOxkpcaDmA83tC1hRDWuu4ZL
	kbXBC+bf7n15IFLk6YIfjGX1I3w6PvqaWiXCuU2UwpvonkqdNhMeAIwUTNc59w5bA919z3/h+Cf
	aF9EWNsZxbIFfWoPILVM2l0kwPC615NWyhcmLJ0z4AU/g0rFWlw0FxY/Xa6ai7CU4RkeCIaTkK+
	/CPJnzyppG2y7OX58yD7uE08Q5+XTiZNbwKdbpqAHYv3WQahOHSpCkU2h6T3oWHU4b1Q2BA8wLm
	3Fenl8p474=
X-Received: by 2002:a05:622a:143:b0:52e:fb1b:b50f with SMTP id d75a77b69052e-5327eeaf2aamr101848551cf.35.1789638874450;
        Thu, 17 Sep 2026 02:54:34 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.90.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53262021a9esm44803141cf.14.2026.09.17.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:54:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn>
References:
 <85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v3] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
Message-ID: <655ddc59-d850-31e9-6023-329459225f85@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 09:54:33 +0000
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
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35203046251

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/74afe5e0cd=
d9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1167222


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
