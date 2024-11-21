Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586327447
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186171; cv=none; b=oqILFVqCJmsva3VTP2qWHBUsYOm03C/ZdaW+PchjjegmXFljEKHR4vjOfb9smQ9Au8Sh+LYJ82TSJu6Ocj58BsuOcBeOZoMdWCLBR6DNWV2IywYee+in2sIzUUZMJf8QKphYkNwZ1Vkm738Duf9Z2IPpxn9X+aXXIImjO3xCohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186171; c=relaxed/simple;
	bh=9ssLcl86eMHo8DaDVzgLYlIZLTjbCOc2ynKZygaXOHM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=o70YE+QG69vhZCVgOlAEP932fKV/H96joco41DMdMLu5egVGQjPf87lZBU6WM8WjBlVn1aV8LXnX0LZyjMyNDrI6f+qb/PuUh6Bcb6J1LJLY+tvyPVVRFH9iUYtaNE1vvyRF0fVmiqV9RukuUPbLSxC461h58LD/+rg+GvQA0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO+NcI3K; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO+NcI3K"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d41b209858so5035366d6.3
        for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732186168; x=1732790968; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDbNtu1d4ers7ja9dm0gRcBT+zUr8xsfEieHA7EiB34=;
        b=BO+NcI3Kev+/PDkNT9NaX8JB8+7IPr5ziOb85DWbjURhuH8oCvsdCT2mbRwJMHUnfc
         anEw7tqsBsPM8vT+1QfA3nCzyUR+cpb49bK/oJ4DH4fs1lToxTB7+uN/jB5d8h+JjdjO
         knoDc4U6DsgagVaeHiMrg3cNQFNsAPKW9d7PY+Q6J8djV4hcSUzgd8a9ezYVc9youLlR
         eSYJQ6nJ2cMuU4L13UwPtEUgvALPTuidLcCAnG6srYc1I2RRoruVsdMZ2X0uZ9mJV2uX
         3vHyPtomtQ75zyilTfKNIcj9s7vu1o7c3I+Zm4v5jlDFV2V0iX9PVqrj2QXl63FBkXyo
         ufng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732186168; x=1732790968;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDbNtu1d4ers7ja9dm0gRcBT+zUr8xsfEieHA7EiB34=;
        b=dLijl8sDhC2gk74B0LbpVvWdMV5qat2UpjiUH4mHe//6JwrMmGichjMQi2jIWRLnuR
         r5nsauAW8rkovTLOe6syaIcVIf72wWe2JwlueXyeULZKOrTV4PnZowSKgQ9qbBy36vB9
         FgrR2WFkZr34rlOEqN7oEI4RkMoshVY22uHQe1Ol+/1In5u6aQdkQyiBp5bZskSwL0Ix
         U0hTP1FwjcnR+Z470AVsnMIx/EBAcw3lv2J3B9+nH0uYxWhDFvvZGGFT8mZFbrxfiaNG
         2qY+pKyd+HT0KautjmOSj1oBMIj22Hg5/erO3dwEyoNc0HRhhGALWTLTUycQZ4j+i8Uj
         pBZQ==
X-Gm-Message-State: AOJu0Yw4lQP3LR+5WGTqR2/+nRf6cV+G7ymW7uCFuBu/KRlGs7vLSlCs
	bS9zjtG9+QvLM/Tg5N9g19PzLXRD6KytRE5xisCMRI16GyyfbYGdOaYF
X-Gm-Gg: ASbGnctIa0nqLkau3S6LHQUkCyiqK5ic/0CMaop3UXO7cqyY5NrVfoNCfvgntM/MWXG
	pXjwXKu2Yg0vGEj5m99FQjF/qMe8onUtHAakt/Fz+aNMRWVjJy0JPEe2OOndUnkuaJXw0E1ZA0E
	TanBBVII7fJmIjRKLGl7KiO141WdTHUZwUcUHz0m+umnfTY/D+nJv+LRUFNpW0f3XX3/mJI0NtN
	N8q2TcPAbrF56enbFNcKvu3epyv8S7SKRrwIflbgoK/Wl1OF9wc+9xqMe0r6g==
X-Google-Smtp-Source: AGHT+IHOW31IPUUQUZt6H4+j6oaxMFgHihqo5ZEdThipF1oJZrZEpuR0g0jsjfoCHpfcx1pTRsmYjA==
X-Received: by 2002:a05:6214:242d:b0:6ce:26c3:c6e6 with SMTP id 6a1803df08f44-6d437862fb8mr80783466d6.40.1732186168447;
        Thu, 21 Nov 2024 02:49:28 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d438136c68sm21620536d6.114.2024.11.21.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:49:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1732181419.git.tanggeliang@kylinos.cn>
References: <cover.1732181419.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/3=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <ca220584-a363-ce31-741c-3553250b7268@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Nov 2024 10:49:26 +0000
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
uns/11950722365

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9b9060505f93
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D911467


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
