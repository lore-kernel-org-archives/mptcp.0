Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F614280
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709697995; cv=none; b=t5ZuN5oVNlH48h6860gCXM93dWLF3qPi2DiTWXPGoGZhBbyz8lPwu4/3bS+ba1BhpuXqWwZaC/Rbu4pnsBv6v0JsMj10ufns5z1sXzGNR402Ky1uQjmleURuok+Al9JTfj9ZfoUjM+z03X0XsWrxta31/qmuOs7CGCx5r/YRuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709697995; c=relaxed/simple;
	bh=tnLj1sXuNj2CBtjAY35bQjji2k/UGOX6VH/JHauMoms=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Uz3SryA9cMvhx9/BDKkkjN92QSfGkrnyUkuehFOyY0JHZSmu3Y4kVzAr/9iuPwa64mekgh5FZ20rwLhospsAYmcLmAOaaylTlrMevhC49L/fozyoUFw8kOghc9IIucJuYrirYVoe3NN4HLH+yOof/iCeBnYLQ3mhmVHuuyFZ8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMxr2Oca; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMxr2Oca"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7883810ff3fso52690985a.3
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 20:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709697992; x=1710302792; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEUXsHMBDuQUhbchqNDDx/Rul9pG9LNjD6oF7lyluu0=;
        b=hMxr2OcapLwUUFVnE42KigbtyRsxj/xezidcO4xQhy2XYwf8P7xX5frGQem+l9u/aO
         NRhsP61kmMd05/WzJqlElz1G2+jxy/Lppe4zUTAUrLoDc62g1yqpj1TAVuatBEVLzUuf
         elnDRHTXcmR90qoSZiTC/H7vS1AsB7G4X1SFBTLFggL6Nnc/giqz6Aw6B8Lr+Vk1UaV7
         NJ3LRma8BFR9t3u+xk5d5pXt9VUlFwNzAzJ7seqUKAMNu95RqDyq81urAlqEa+pT1EOC
         Mjl52Z+05zNCld4BNnVfO1RmMwQ4CyWRO/O8Wd/ZueNWfkb0S5Xlh2zv7XkCEdb2UFtD
         /9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709697992; x=1710302792;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEUXsHMBDuQUhbchqNDDx/Rul9pG9LNjD6oF7lyluu0=;
        b=pzxrTz5cGm8hv613TNR3/NnyfJotfUmQ5Kn+1fwvXor0ebsf5Fa+la4vrOGdlJgGfW
         WyDeOiRXqHYMsx4v+CiZasdqLAQ8SNdIAbj7XY2T1vrS71p96Y2qnbVL4S3gUg6+w4nQ
         w1QjBg4hmoDzSMqsZ5NP9sqknFSN5WsWwDQDGXDwypsHdABoAcHYZ1Ak7E71tNaBokXP
         q6uvZ756k9siwFsVrOH2j9ubBK9JuopKOAUaOOuf6d1wZ47ckWZdcGHXP7gx7d6Hax0F
         tXT2gl3x4pxyHP3WgfSqhg0CZ2kyksWkIUfk/vNv6rXpuxYUcxTKQGZ16A9TsEEYLeIk
         P8oA==
X-Gm-Message-State: AOJu0YyVEaz6Q6VHFJWf80LA5AUkxsUO9ObkpkN8sCelnWZSUFt7VSkM
	BQw9Xl5vaMgE+7QBjvcK6QjZuZ3kNuhktjjwo6rqNHfO0Aj1idwJvYlo9vE=
X-Google-Smtp-Source: AGHT+IHCUhOEjVjdSvcJZ3yGaifj5A/xZYDnVOwcgBP8IzirNNBeK2Ef2G5wc7KO+8iQLBVsNOyGmw==
X-Received: by 2002:a05:622a:1743:b0:42e:bcc4:2959 with SMTP id l3-20020a05622a174300b0042ebcc42959mr4214800qtk.4.1709697992550;
        Tue, 05 Mar 2024 20:06:32 -0800 (PST)
Received: from [127.0.0.1] ([20.51.198.162])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84dc8000000b0042eed783365sm2953655qtw.40.2024.03.05.20.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:06:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
References:
 <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
Subject: Re: mptcp: react scheduler when subflow events pop up: Tests
 Results
Message-ID: <f04128e1-f7d0-fdf3-ab22-cebdc03dbacd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Mar 2024 04:06:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6251159791337472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6251159791337472/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4843784907784192
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4843784907784192/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/218fdba4f2b5


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
