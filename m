Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48A456DE4
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841079; cv=none; b=SdqPtWeHZLDax457goh44S0lrX5cx9Zih5xHC1Ks1A02sw5rAVRnvsHa5YQOVAzul7swOHqYa5Eq5Eg37gbAXHLEK72KwMDAj/Mq8l+hZwtgxdIe/cA3hTxTcKaO9vPIKx1Z2cSzj3nDkU1obkKauKcHJkzg6qObUlppF/RwGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841079; c=relaxed/simple;
	bh=hWBexvjPaDQeXWbPgnt8K2kV5Qrhb0v+sp7MmP9XA2A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=nvuxYlfiO+hjnktUxQ8dXC9ZmIDAb4IwNMEywUJR7PPn1p/90KScAj6tTDVZz7x3e3s57Laxp7CTtfAa2lXZGa3PsAbSvGGRxSUwxLWVMNNhRL6plDZM96DowfmOZcIh3rESkmiwHO/FCkAPRHhLMqc3+AZZx2yAwVsMCz3TamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH91AQsQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH91AQsQ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca913a601fbso3111248a12.3
        for <mptcp@lists.linux.dev>; Tue, 04 Aug 2026 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785841071; x=1786445871; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dNZUrFsCDcu5lbtN+VxFHlzhitmeXi8cLM0b+t26G08=;
        b=bH91AQsQ+jpH6CzcmDhfIIMB5k6CPHinvGyGu+pvAjUIz/uq6+c0RYuhii7N/IPVeC
         mDGap/3Dd9vbWWDumx/0UphvcZxLtez37YtJlXgwAzbXNaRunpD6uuyW7A3l0FwUaI5j
         i6CZdegra6AUImWzds9w6tn3xPBJoNBQJFAml9CpTiXXPW+ZMkKKawftuZoZUwawnxpg
         Llvo5LM2vKNwz8DLs2JfGaBDuoah/yqvv32uoyUG9mysZwM/c2f5okurRWKqF6ZhywyR
         u399svtn7zmmxfctQuLebRuleUAeAjFIR6+I7JCKMVWazVbBJX9ML3aKuyO9+7CIpMIZ
         +SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785841071; x=1786445871;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNZUrFsCDcu5lbtN+VxFHlzhitmeXi8cLM0b+t26G08=;
        b=O1RH+cDFWrS0XO3ZHnG0sM2Hm8QMsKrf0PcvZG702O5NGYOFdRGl94k7Idvfa2Tbfq
         t7Asyy0XgmY5ILaj2smlGNVhDMy/SJT5hwmJCUzwHgrghgRT0dkl7xkHndl6e1YOYIsP
         OJQQ1HQ4yFx98HknWGWKtmB2MyNsDGy8TSzvQjZ7b/3+07VrzIwxpW4Exavo2sApSijT
         lDl2aDdVZgtnhGEZ+Q0+KV79hFh6V+juGhqI3eBI19rMnrLOGwrH152nGRmnbWWQZdf7
         cx0y6lmkZAfpl7ZW1Wah43ylvEA8gs8pksyTjTCo+j+nVUPFNoT4KCf6VprlHDREjz4B
         Lc7A==
X-Gm-Message-State: AOJu0YzJqclkvCYS6VaHuPaBKCxZoaCbphMpeDZONCybbL3jNDaZBoam
	Ls+AqcdPxQafmTedCjATwhaWE+k1Q/bO0137rl37F2ph7aqt5yKCyas=
X-Gm-Gg: AR+sD13zrCX9MZf7R7OG1svtR8C9495l5oCQx/5Bcer0FIfWmlpWgBvHmuN1iMFgp+4
	ZWyVBxVNIkLwERXh5g1IwbRA+nusQHEvGR+Fw+7cQsCoOvPiPaxJP6D6/foK/XREr+sgmaLmCMI
	HlgrqGyTXtFt0EZTVk23PJgwofTkWjdIKa00Nu3uPFI2/9VyvXhqHcnq0bmg/A33o6LxQ2WjCHM
	d7BTT3zp/LXGuP28/AvfMzWXVQDs7L52Ys2gtHSUlUGmO0Sp7IECXpIbxYB2yxk7yk/uL9EZS3U
	SRmkj3TXoVfbPRrddCazlIfpELJYdJqm1zDMgBAwSqPIPn7BEjBYakXOkJwF5LNbx3uaZhOiZTo
	piex174fHkyYjg+eAJ6YQwXF87trYl6e20XB2J0uzgGxMZtsW9Oiputu2jVTxHKB9nX3x0ANPAR
	ZIXhbu716a4MBMKLfmstXSJ3m/Po3sM9Y+SKeVINGlPSM860cnz/NpTDMf+rYEDuMFFtFVwsGf
X-Received: by 2002:a05:6a00:92a4:b0:84a:29a7:f3b3 with SMTP id d2e1a72fcca58-84ee493ea79mr13005768b3a.68.1785841071525;
        Tue, 04 Aug 2026 03:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.174.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7a243sm4967756b3a.24.2026.08.04.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:57:51 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260804095051.715355-1-david.lee@trailofbits.com>
References: <20260804095051.715355-1-david.lee@trailofbits.com>
Subject: Re: [PATCH net] mptcp: hold msk reference when cloning request
 sockets
Message-ID: <ff2fffe3-d52a-2038-b327-b2a8c9ab723c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:57:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kyle,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/308992=
32462

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a0e78978315
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1139981


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
