Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B91EB195
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678234; cv=none; b=tpUpbBD5tGT9bjGoE9Sc6Gu48IO7THwxvyhIaQCFa5J2lTbeoz13kdc2WnUCjsnR3BpAeT/OU87OrYxacl16masKnREK5lUDDU8dUZ7JkPt2m48HEkU5Po5Lwl/KLO0bSzsiglJVPvtLyBCg6bj6hAT8rskDwZpvmvCFP7K3GHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678234; c=relaxed/simple;
	bh=22ncF8CGnrsT+5Sv9XhsJ6gl8bdXjDP4NjgropXKGbo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Fd0T/vM5PxIP2c5k8nzdL9VDJovnDzeAVF5VAIW27fJIYn3pbocRiYkvWgtjFewNPETmUIoOCJtcuPaAvpk1hmkcXElw+zqBu2hhtZY9KKOaqvjFlSzR44chI8Ni5scG+1CsvQ8RzN7FRyQy+N796bRxM0eoO1CloeJ9CxQ+sSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqHSe1qu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqHSe1qu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c089b2e239so459822885a.0
        for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741678232; x=1742283032; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpKbYlyYQqi6rFP+FK9H8yIp6Z4fm6+S6khi2A4xdfw=;
        b=hqHSe1querExeZVDtahWhKB3rQeUl0rKqE+5hGBsnEUssdeJ9xUmDtjGEKMW5MMf+L
         qoKV5W+T1hvbfP14Vey58yaW+MjMBjjvSIffpBcRN8Po3A9/8s21t7H8rC8g2UTCH//b
         4KCNERw88TSCZrr1aJs7WcZgMGKh4noUuYtBsKCsRicmFUdPqOj6zjIHGzZIgQ0E9+0c
         9Urb3nfd0zYsnSPfgDqFr2rvIjqLKY3ycL5mMKOTgiovft3K4mxzMvgNI1REgGQwMnz0
         hrFNXGOu/43XkLDTPfEtdyzNMto5sUEx9Knt5NPIJZT2wx/JdLet+4rRErS9wf4e6SwK
         l6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741678232; x=1742283032;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpKbYlyYQqi6rFP+FK9H8yIp6Z4fm6+S6khi2A4xdfw=;
        b=nxIRlExs6qmKLMphlTS4mUWI6Ra/n8DY6rBFJG2G/FI012KlTzRNRFNUQvsBBi+zAn
         cy3fn18s0mNonlGCBGpfyOFAfccHk87yNMj94TkSFCGFMrnii/0pj/1YWwGAcCr/MI4X
         wh4RE+gapYUx2IdCIEORi/0SG3MiPBEgfsMPzXKim13ygx5vREQZlDI/0/gwzvQ77SKx
         TNQzUW/t4uhmnX47Cjyr4/iDNBPCTysIlD+CW+p6u7IzmFOijci/LcXLBAT3oBS/fKcg
         BlPJOqW/EJn9a/cXGgzLe5jpEZyjiUDWkDm9+xR5DgDxs0dAL+MOTf/tGUW9FCkMCLfu
         nLuA==
X-Gm-Message-State: AOJu0YwyBYlPTG3TgI/WFYQw9uYCkeme5uzA690GpyC67aul9FaCYlfI
	ZcmCCsFHqCeznSjAG6Rtp4KspNp9qkJeVF1q6E+8rZUCMCa22izYCrKm
X-Gm-Gg: ASbGncsPqqkE0RE0fnIuuWfqYSgg3RAr0peUWrKZZqH8V0+DOBFWP1G5PDB6AtHCHqS
	oury+5fy5H/Urs3vcr7VJgzErddtpKBYcov6eXEm8l1dlYoiwp6hY0Q/ZsJ3BU+sdol7vsHHRDN
	ZdjxdHbTN2oksjMQiw3D2q9zcPpXhNWTDBJU6Tlyw5XjAnFT41wb+wT6kuEhK9XXAjf4Lb2F287
	Juu9M/JqxKfJ3cPLEfkQnW0hngW6xgQ83OvI+qbtrT6j/jDi4/ZXnD5SOhau4cEQmRQXM+Oawp5
	8dl6MCCH79aaqS8B2hMH7dVG6v0yJLU8XeZyYjUNz17xy+RGmojmzquz
X-Google-Smtp-Source: AGHT+IGOWeSwWI89NzUo85P/q5wG86nn0xQtJBGmpMU8MCEulTXNrAe8iLU72pV/Rmxr6qwQ2MDqMg==
X-Received: by 2002:a05:620a:4883:b0:7c0:b018:5934 with SMTP id af79cd13be357-7c55ef126cemr362830485a.27.1741678232038;
        Tue, 11 Mar 2025 00:30:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c55f112215sm102617285a.109.2025.03.11.00.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 00:30:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741674101.git.tanggeliang@kylinos.cn>
References: <cover.1741674101.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] add struct_group in mptcp_pm_data
Message-ID: <26b3f7c3-cb84-8f78-a8d4-f4d0557bad74@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Mar 2025 07:30:30 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13781890400

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6d0529e1674f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D942573


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
