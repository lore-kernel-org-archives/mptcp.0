Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02403229805
	for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786403; cv=none; b=Y2YpcPq0ZmH2xrWFG3svR0AxV7aQdynDJ+WjANnaC+VRfD6fKJQYnK60EpYQTyTYfjSKNRCXIEistyw0d/TP8GLZvE4pPVgtggxELFmo05AukEyJBn++AuxpL7GvlFLcYCN60fVsEnge87IXLQiVgeZ6iiRUOAIbE6U/G8SYp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786403; c=relaxed/simple;
	bh=1dAIRx7esVDwAofBtWBnQZ8aQX5+czikXXt3baRNZwo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WDMWOOlafKI1FNca+q61oPEnH8KbJbu7vRqcx214wvXGWAVk5utjd174X9LDdALtbVxCXCHFH7ENk60AiDYEF53W7tIqe//k+6mjVM08V2Z7/ydg7qBu4uczcHEzfNI5Q6W3ZdwLCXia3eH1Mma+JCBDpXnmrMqSs3Abm1u2kcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsijWKfA; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsijWKfA"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd16e1cfa1so38908976d6.1
        for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 08:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736786401; x=1737391201; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwbBFmarDc3NqagY+OX/OY8s4bqOvHNpv+ZjtUY6Af4=;
        b=nsijWKfAOIUb3ar8rp/o/XJ3iuF/oI/46b/DgIipLMc4HIp+sGf1C6rIC9nNnmrjXC
         vNG66KvXi+Z2hGlFvZDZeSH5Y2Szn10SB/nq45CILUAuB1dB1LdlRAbCPKvXRVBkJ+Rd
         A/ng5L0MJmK0/InfPDDEqjN9I88SaveVt2wQRRNn+YvtFrSlJPS54CQuuJL4PHQwyetY
         xRqV4YtpkFvAY4N5Od/89P5jkUidd5/fKdAJMuLqdtyOnwC/sc+yolVHt17RxyxvrpkY
         j8vKZJZ1XW+GL7vxqLkKruZqR/a6DXOVRPdpHiU4F3iu7zKfOfUSlawGXmT+sIq7BEqD
         l8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736786401; x=1737391201;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwbBFmarDc3NqagY+OX/OY8s4bqOvHNpv+ZjtUY6Af4=;
        b=GxS1Ysa5s53t2lIrfvSk8Q07Ruj8YYJOz/rBu46WkTFCB0Zv5pRXtGNbiAmkGWEGXA
         UxS6bolHX/8YkJolmDiNEOrkthxrKj5AuDQdl5mBVM8p4UafccKoF/FeaLn5wFgoNGeA
         wXbSzhmy0AQ6QgShT9bCyU38n0U1ncuRwDdfaUyx/0RcDF/Li9A5vJc6IFt/GtYdpFD2
         Sq/nmJ2DvUmltjX3++dMuDE3dBMafPNf7nbh+3i1pK+/wFnXMzkPxxZgVsdfGuhfnwtj
         1p0uw8bMR7/awdrjK03q4ur/2s+3+GQfHFUMElv2sWnO0K1ERtTiuku0dmWXQPJba0fs
         PiHg==
X-Gm-Message-State: AOJu0YyYNOo8xkf2HHDKlgyFCS8gt8SvUVLtiS/IW7MB7QpGbG4pcNv0
	3bPiVlW/ev6OGh10IjRf6sxJfj4nZcyg3FKj2JKn2wtkcNiSq5O4P4ay
X-Gm-Gg: ASbGncvUC8GxUEsZkBslF3lVYGjgVnZPRuhn8TQaOTzpCjd7A2ZYHdnQPUTHSS4ZCUz
	QhWC1AFH1Y1acrd0H057r/koEaMHUByjX2J23FfUdgV8YPn+SXkZMiLzB4ja2r1udtjvoBmTpDK
	RexwPkzqeeDZZIq5tJmD0biTrOPkPG1v3zYPMLckzdzoSKZmbfYgh3QdOVzlmOGCiODWD0vLB1W
	BoflTN3t1ZFC4Ja1i5xw29aGcS/rRSft2d872XxK+a1y5lAo+4pm+Y4DqanZIcYPQQ/
X-Google-Smtp-Source: AGHT+IGFZiOP+0zeXlbjpBC4PhSRJXsMpRy7+GIwAg+4+l1e2vivLXSc0E4ZeLlEeaF/Evu2vKUd/w==
X-Received: by 2002:ad4:5748:0:b0:6d8:8390:15db with SMTP id 6a1803df08f44-6df9b1bb828mr282718326d6.6.1736786399404;
        Mon, 13 Jan 2025 08:39:59 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8732331asm42748651cf.11.2025.01.13.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:39:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cong Liu <liucong2@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250113085228.121778-1-liucong2@kylinos.cn>
References: <20250113085228.121778-1-liucong2@kylinos.cn>
Subject: Re: [PATCH 0/3] selftests: mptcp: Fix various issues in main_loop
Message-ID: <eeaefde6-cdf9-a077-762e-9738fc96d07f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jan 2025 16:39:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Cong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 5 failed test(s): mptcp_connect_mmap =
selftest_mptcp_connect selftest_mptcp_join selftest_mptcp_sockopt =
selftest_simult_flows =F0=9F=94=B4
- KVM Validation: debug: Unstable: 5 =
failed test(s): mptcp_connect_mmap selftest_mptcp_connect =
selftest_mptcp_join selftest_mptcp_sockopt selftest_simult_flows =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12751035845

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d2149d21eec6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D924794


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
