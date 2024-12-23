Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0E17E473
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734943481; cv=none; b=d+7+0bY9NzbNRrJVvj3EASi6/lOw0qXUH3BR6fDI1d3crAti/zZrtDOxTXy8e/XHecyF20C5lviynZNiGpblucAQI5vegpRNim6IOl2h/f2utldC2iO0aU8xk4IJ4VN+N9yNGzvalczdBP9DG8UIqUU/rWplU+OyNIUUoPlSFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734943481; c=relaxed/simple;
	bh=JvvqoZAs2OKQ4xDYrVK5+j14Dl351XuqdzgeYjk0wKk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XXBZoFJoOc6xfcA8rVPvExbWUPzjRSKZJ8zMcGEnfGqrUM/vwlSR/zjHX/TGREjeg/eCzOmtT5Vz8aLQyLeB/oO3r5eLtSCnLaC8a2BAbBT9ghvRxajKb0XIOVe4Ra9snbjWeJcSyUoVJm8yDiq1eoqXWeLZAK9utX9926LVsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8B24pQy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8B24pQy"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6f1be1daeso367596385a.0
        for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734943478; x=1735548278; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaWmDWi1xEPmnKY45e+Sgc7lXc3wHzgGxPRMG4OFeqo=;
        b=T8B24pQyWP+OuL53Y/6j2jpZcsEu0xJPzsbm1su4dpi5ipKJccI1o8YgBrCHbpjypo
         7npf5IH/PehqG9HxH9iS556PpoX9081FqzCsb47ars9TltRVOYbUYIxS2I3tgmVOsEUn
         OkCM4RDwbraIrgkcq/sYn4sXmSNWYBPSLtgc2BNODM9TBV9fr63peosrO4RjA+vLFhMV
         NXCsn34zKD9GPs7zHz6RG2G/6cWDxilFGRMavLXokcxMuZx19EKswe4WjJnmVUghLt1J
         ZEWqJB9ha7/rITAJGDxVRtg31jkWJH4yGihtf2FHpuwzuAJkFqehiLvMxn21UWBXBtOO
         Ah6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734943478; x=1735548278;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YaWmDWi1xEPmnKY45e+Sgc7lXc3wHzgGxPRMG4OFeqo=;
        b=c+Kw2w9HeHAb/UpVR1FQGXF9aJCcn1vrhzGmenfv7beDWnTUmM8umDurfQR0osDvu2
         mp17i0Fn7FvDVcvoaZWUmz41HsQwfyRZBp4AOMhWQWdVkvZwURLahTrYSlwUZosdnBSi
         lOU3nO4btnk1ilZMYAxZ6/mbHgVk72LWv19ufEs/qDiJPJ+JdikQMfoKkr84KET1aPn/
         xh6lHmHArmDIhAfDq+Hnl+EpERc+NOKQo0jIDWe69kumPsZkv/xTAl2p3ALwG9bPyXZ3
         7U2DI+ASII5iQVQVSJ2buSUQvjUrFJqf5TgPAaIsCp/4WFBLW99TnvhKxZGU0RkUV61M
         gHxg==
X-Gm-Message-State: AOJu0YxR0azBz4RNTT2TzzcoR0R1JVlhefbZR4wzN9zVS4Yo2l20VtN4
	QEjtzFSITNoVfLHoKnxewm1tPJjd9TCyeP1AsVRaY7dTtn1G1eKWfYeF
X-Gm-Gg: ASbGncvxNGJ5EG5W0zGOm6+xfQflZ4DC1tDUcLbbpQEJzysyTdb9ePVqfBoW+5lVF1L
	dUvefu3l8mZAt+tGmFV7xwP6KXiAW9n7HMhylT6C55HU64pJCTzxPv2irmnp8MZNu5ls9fS51I7
	XAHh7bpvXXUUrrXPX93P1J3E4Ex58aXYH3LjYwvtZXuSuLPGBtUnVbuBqT/VluFuzauNAqso6LF
	Nb1R0hd4lTPBBsMJ/lpEUR9PitCGNf9+h8UoesWJWIC1lxrMta2yUxvTQ3Yrfop2Jvz
X-Google-Smtp-Source: AGHT+IH5U/WQnaAqPlBXBfrqoHoXw39g1TUkUMIJeIHiyJz5BGfMiUVpGxzF7rBS30u0EiMHNnSpOw==
X-Received: by 2002:a05:620a:1706:b0:7b6:ebc6:181a with SMTP id af79cd13be357-7b9ba7f68d8mr1689763485a.41.1734943478495;
        Mon, 23 Dec 2024 00:44:38 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e67790dsm42353781cf.25.2024.12.23.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 00:44:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/9] split get_subflow interface into two
Message-ID: <779a6372-94e5-93b8-5b8b-74607de3956f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2024 08:44:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/12463812840

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/cc=
75b61e9055
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D920351

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
