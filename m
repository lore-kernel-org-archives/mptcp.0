Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2012040B0
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249545; cv=none; b=b4r0AaXAi1UJKuq53kvBsm60R5VipN50n5ypTXQh0r92ULLcyv1GrJezaprxBiwM02uaXAEgsMIVezYewiAxnowRRSmt1MIhTVPpQWoEuwvCLCF5kK44ILnY+yo0kSpHD8Gajx+oAjs8Bif2PQkccc/D/B1e9dafAcHUnU3OMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249545; c=relaxed/simple;
	bh=1F09zLmHRUMsXryCDpXh1KMlmHO3+m5OCTa35DqRZ6Q=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KdrfpBS4qsNDy1rKShT2+W1UatMwDw2PAa3lxBEZo+L56mUic5S5UYcxeH79JvuUXFBQfV5lhIYIzw1gyaVfJDmLs7SVJzH0RAuonA+l44+7IMCiqOLxgx2PXnwusm4Z3YjIs1ePMzNVGWDFSw9U5Kt7i5Q+6vomtOah7kesj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZClSYkaD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZClSYkaD"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso10953466d6.1
        for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729249543; x=1729854343; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikRTc7DNzfGZb+/GXi56OR2QZJn42NAlXJmuOH2+CvE=;
        b=ZClSYkaDykdLqeiW0ZkezsXlV2SEIgV+9m0QK0KvWzbVudBGdoqi1zFFGG3VvmPKl7
         RxiD2UEKFI9atwq1bp2wUc5/KOqXa4op0Cg2kkZkgUw5neck86iGOAaNQNrmRV5sbQyS
         KuA2ksHfjOoMxRDb4LpLJ9CYzYnHpDhRlc0tnvFj4Gx2sPJCr6x6iLcunjug2qNbKFCq
         ZRUrcr2aSHRaqMr0oPYoJElkTkfeYiAT6p7V5bZQrWbkkf0tnoZGBcPM/IPzJDP62IBy
         EevW2m5YDpqTaSb3I9xSAA2IpLWGV0Cu4l4MPqgVfWv0vCjioP8NopWJJXAGiGfsnWBm
         Tt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249543; x=1729854343;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikRTc7DNzfGZb+/GXi56OR2QZJn42NAlXJmuOH2+CvE=;
        b=NBgqkJtl4K1HTK+FgoJSNvQNNJmP2AeUHa5iASHIWNG+hGD0usxnnEm3Ir72J+4y+8
         f4xyDBLanfA+RPbPxhcCE+09bAm6CnXBiIuE1GohqQYp3ZlYA73NThpm9vUzSq7v4mHD
         RmPrlrII1aVjG2mlUBZTRquAB0Koz4qFO8l+CtNYBn+KzDAkOv3NnfazcSF4ZzFv1ulN
         s5t6gad8hCZdVChOflLEirYyiyBHyBLSoDeYJIS451eEEeH976w4ssJEAKTua9eTFRA9
         K9iLK6uE0BWgwSFZqTZw8QjduvsKgkO5WUbK48b45aLcdWlqB7Kylvgmn60qrbC47mvL
         Ydlw==
X-Gm-Message-State: AOJu0YwgsNrsAT4+xDlMmlhph3XwRsC4DBD6XUbInwvPtTrXnUntfZub
	qyQmw8yuaJIdpAn565kJyvXMi5vUgR0dCMnHUjJj/oAk0YhvfK8/GMbH
X-Google-Smtp-Source: AGHT+IFCWnK97VixEMPhQcsp+WPTM6pkiSuhCsqrbz+aBM8ufB7sPIbvmXrQJHztHqytEftRF2es8Q==
X-Received: by 2002:a05:6214:5f08:b0:6cb:d376:2b27 with SMTP id 6a1803df08f44-6cde1547851mr25864546d6.29.1729249543069;
        Fri, 18 Oct 2024 04:05:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.46.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1366d2fsm5917586d6.124.2024.10.18.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:05:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729248083.git.tanggeliang@kylinos.cn>
References: <cover.1729248083.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/6] add mptcp_address bpf_iter
Message-ID: <454592d4-f34f-f743-91c9-5b452fa9c441@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Oct 2024 11:05:42 +0000
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
net-next/actions/runs/11402403690

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2e=
487a9e3d12
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D900658

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
