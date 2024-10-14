Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F314A3E
	for <mptcp@lists.linux.dev>; Mon, 14 Oct 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913460; cv=none; b=nHVHjbxG7T9H6thDc1s7UEr1s0K+XnWw2Nn2WStmCtLBomWFW/5P6HwvmSPyoE9va8u+baDSu3MK5I3gxy8zJU/xFEl47WV/+jlHW0WBfWCuSQWeWL9MxsLgN4zyMQ5Oi6n2r3kzDsaQ18kF5f2CezTcg3kbUJSTOGN2abgpo8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913460; c=relaxed/simple;
	bh=jnHZsruZFknXoSdVTcB9Rzh8kUCO8i4PmBiGU9vX4DA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LxOKArGF9qMUxf1UUouGgi+cN8IpEfrUY9gX77z9niMsOyrlh/nebggd7g1X7ku97PBQliQZRiv707bbsYslcWLk4zzRUF2YVLb4k+ACFR9wz6RJ0kXhkRae+vdiwqPppWlg8siByGg0E/DfrS4HX9N2Vq55AAsJAxZrtmE/Nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC+GgE+Y; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC+GgE+Y"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7afcf50e2d0so206506585a.3
        for <mptcp@lists.linux.dev>; Mon, 14 Oct 2024 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728913457; x=1729518257; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvDFmCdYui8BARwj2zmWOaSPFSJl0joEOycANWQ12n0=;
        b=GC+GgE+YVJdwd73d2xchrDQj8w2s9en34q+0zMAu4lHMxVLpYUMFjS6lTQ8yqOhQkG
         OIC7reSxJqVsv2Jych8caRjM9agPvE1kHlMb0xNa0TL1FIs3bkoB5j4v2M7ccLUegPMj
         d8p+6CKePax6+Lvcxt2VmNLhy3v6GdI/pHHe8o+wCNUyz3pCVDImsY9d1csta6WLlc3q
         fjQcRyTJb+CGYLiw2MBF7lHbTxcLJVfuuT6LYU0VvyEWElR4IOd0YD1XHNeZf5jSZP0Z
         BuhabPEGnKTmw/TBEQyziOK8HUzg7i0sG1c6CCEeZ5FlEKle7H1x4YD6gAY8dmG+410L
         Q+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913457; x=1729518257;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvDFmCdYui8BARwj2zmWOaSPFSJl0joEOycANWQ12n0=;
        b=wzIXzGsnVZRqkg6+X3NVOKrseuUgfJGpoXlDw/3ywg9fI8KIN+SsgotqkrKK8sWdfj
         4+DSYSWP+Wc1NfXiaDTq/bNJzOXmJJdPrvOC3r6ZqzGIQ5eL00t0Lqs+qSipe/x8ZJLQ
         Vxqf/FNmvpxoLRhHR52+SxEneD5kd/6Y46jbtP+k9f5sT0/DwZsDOvsnhqkHatOSNM+o
         aTb03bg/p8SGP6LsurgfwGNezz2dmx+R9VctKb7n+UI9b2buOl0qTaGpjPKFQLGFj6dc
         4QfJWg08K0c5rHYs3ji3z3/UrTeufMTiBxeeYTLPV/Z7DoknweCfUMwv7bF74bSo0Uv2
         1f4Q==
X-Gm-Message-State: AOJu0YyIppuvtRdfEcHduA/sVNYb3PjkSvKc7Lvc0EJhHqCjE9a8V65P
	2O4NGc5fZF0tf47O/U6MR3K8Vr9WrdgQl6k2+AQ//MMrV0ID03XrdiUnEFQ=
X-Google-Smtp-Source: AGHT+IEK1TzzMrd+aENg1Lk0/NIQurfMP2V3RnuLe4GzI5+9Ao6RUBdx4AdNrxBqpHqjJ7e6rrZ9Ow==
X-Received: by 2002:a05:6214:33ca:b0:6cb:e6cd:82fb with SMTP id 6a1803df08f44-6cbeffe5aeemr199155826d6.22.1728913457491;
        Mon, 14 Oct 2024 06:44:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.252.195.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608e90sm45745706d6.99.2024.10.14.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:44:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9cde7341aac14f85ba9741e70e2d542edae5a1ad.1728911803.git.tanggeliang@kylinos.cn>
References:
 <9cde7341aac14f85ba9741e70e2d542edae5a1ad.1728911803.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_More_endpoints_for_e?=
 =?UTF-8?Q?ndpoint=5Finit=22?=
Message-ID: <b4b6e006-0f9f-68f8-5f69-c60196d23973@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Oct 2024 13:44:16 +0000
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
net-next/actions/runs/11328728635

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/64=
5e77d4357c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D898896

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
