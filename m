Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A28212B1E
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557973; cv=none; b=ST5VRKQsxOKm2P+1s0tVTtwyuznHfHtrsZuM2Lra8kAtJMBgHkbHnl2vwX16y8Z/RLLPgIKJJiqnyXy292OE4G07xvWGgY81ElU6euodgN7EbVPb9IP10BvypAB+15hU5N5eyUm9F1wWGLgT0D5Z+d0lVIwlAM0VVy29N8Y1VCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557973; c=relaxed/simple;
	bh=e0AzkQ0Zsj/K1Y6zmpF0T8Om2FjbZRdoWx7DvAhwmfc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oMb4hrPc8M1keMy7GC0DBSVotQhQ31IZU/JLjR2qnM5AnDfKg06xhRqE7Tm5blNtYZQ5mu+vZqS1rWMXX3nnwNuQnd9I1sAx0ckAWRRL3bZUvVHGphFMWZ4SXbQDmsKT3dM2WokmwiSv84OcSxJ60Fa7RR7XxEKM69sj1+KkZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw53zvOy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw53zvOy"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be8f281714so53942285a.1
        for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 06:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737557971; x=1738162771; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHOjk6EOUDlWNDE7PfM4Frz5ypPDMXTQUTkVaGg/Yz0=;
        b=mw53zvOyIGlP2qqiY4qbRL6t5flHZV66F4qhshKRACAAgEfKGNTkKoKj88LW4LE/VB
         9573jrgBaAXuS1ZhK8LBrZIVtlaDDn0J7o+NgTG9JfSiI64TXiJaQmVqu1nWOlHyskEn
         ADScZW4EI4ZPEzHorjedp+ViqMTNkfo7qserp7Drd5cQTaB6lBFjx8lTRAPlJ3pWh9qv
         L3gkZW8kk8Py+XDT+q6+8MQDSPoRQjF22ieO0AzMP2z0PFyPAyeqskF4cLxU0dZi1sJZ
         +Jwuqa5zJNDvxSdUgCiY5+TMidRGO1Ve+6zKps6e6o+vOA4QVpLhAjZi0jvxYJD2s/3Y
         VoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737557971; x=1738162771;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHOjk6EOUDlWNDE7PfM4Frz5ypPDMXTQUTkVaGg/Yz0=;
        b=E4HlItqtM4RdY5XQOpr/4ECqUjrNK+Hwb+7UkIJ+cjIutcWXIbsYZu3LvxuMZw0itC
         it4E6lHy2LlRLlcRz9UhP+YujWNK8I+Xz3ALzMdseF9Y0FhfTWShVsYR5YcG/mX0zSNz
         hp3aX3+bY+t3RgH2iUlwIHww1/V8+kbKrSPVIR25Ysmo1VPiPKHc0Ve42cyS6fkDSGk5
         0LNb0JbehGKp0HeVIfZbyAYlmjQxaQ8rjGQHqf+SUsLmYsJfUP9AlmcCmJliRS1NFQqU
         ST8IwHeKbWenweTtOvUSe9HHIfoWKQGb9npPogSzhnS/4oAeMp0bkc3RFkZXXwZqmbBr
         j2GQ==
X-Gm-Message-State: AOJu0YwN48KAhOhZazkVONPOxV7C7G6xyd5GxZPTeeEajJGZRbSwfkUU
	pkkX/cY/3R7KFk+sqz93U0mmvQ1k7KKiUAcbDurJouwkLEconHdV79o5
X-Gm-Gg: ASbGncsKyyCVdmLl8ndbyNZrZsVGVrFjtj+oUVyuI1b+uKGxJZoCC4jq+y4ocLy548d
	6ZiIQH5HHiMHGuFBSO9aUa/HzeOmrFnGGQnjof4k6AI/CWcBezVEsfOCVNd0EEjUll4I5Ge2HoL
	hZAUld2zZloFRzPqDchXdBsFkHfaAnu8TDAf4oHhtpNnyn7P8h3kGdntKBiTo4KM7q7nv7b8bPk
	P4sPhaB/26qpNbXFSYHF0uIfaObUt4aCOUIlVUcqDVzPpWyI6hPicUKxq/S6NmB7L1bPvas+89j
	NYGb4Q==
X-Google-Smtp-Source: AGHT+IEydNbRETgadfboxSYslBwbuequDHINScVy8lo399aMsUd3tqZzOe01hKUrfJZCkrmQ0lvSYA==
X-Received: by 2002:a05:620a:408c:b0:7b6:73f5:2868 with SMTP id af79cd13be357-7be6327cf41mr3042040885a.42.1737557970721;
        Wed, 22 Jan 2025 06:59:30 -0800 (PST)
Received: from [127.0.0.1] ([20.57.79.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102fb9a2sm64535031cf.19.2025.01.22.06.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:59:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
References: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: blackhole: sysctl SYN retrans
 + fix conditions
Message-ID: <410581e6-f6fc-e699-2223-f75b4b95ef2f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jan 2025 14:59:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12908221707

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/922f9e419c68
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D927518


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
