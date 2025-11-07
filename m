Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D979DA
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488944; cv=none; b=HN3L00ZXvBdMg+k6yGQsFNvSUWXbZK9ksE1KrBZumGfb4UmqfNTD+jj57wwWm4fTe09wCUVaEAp1UrRcRV5trucxXPVb5YhSf1W44i1g4LLozXn23wdXr2ISgFCd8PW8wq36+xa/4OPcgOY/5mOobai+FWNwRW4iFweWTUo3paw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488944; c=relaxed/simple;
	bh=NuZurw0JGzswtGjMmzIihiE3snOX9hDOf75lkIqnX8o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GU1jVvAl1RZjMQPRRMP4EMgTxG1PEwmbf2sT8xnwU22bB1nVsJi4ZtNl8hyiDEIamy7YJV4prroPHm89fHXUkWI+O/EC17l4GCxQSTu6+Yqy1MEooCMBQ/pNRifAwHed3cCXZ/1Ln8K4oBLE0ROh1tLKXKjVPpbnhK3lL5iBvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGU8f4I5; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGU8f4I5"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-940d25b807bso11707439f.1
        for <mptcp@lists.linux.dev>; Thu, 06 Nov 2025 20:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762488942; x=1763093742; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jj+8GmSM3Ia6Gzd6SNE/MpKX985VHdTbB0W6OfaqhfI=;
        b=BGU8f4I5vxmdsjv0uIWn3stSF+h6x7t75GShvXbOfNIFEKxvbP4pJIgjFQzxoKZpEw
         LGMr+T5xUD8zHIY1g0sfxiyqDHRkvqdJ/cca55+YxYgKbRTuaytnDeaydA59P2SMckic
         yejxVHQYRvULwR9p2JS98BJ4BUDlmPbkVl/oHL+MGDPd18KHP82lrE4rBqu6ifEFAJVX
         3Wsr8Zq/EU5UQ9MpQByW2WuzWljI+kL6643hOU0h+2mgybPSz/1CTpsEn/QulVuf50fv
         9PGqzbmhQ13bfk3KqX2uzkZpSrgX3F4sQsdTDEI+Haao3P2pln7unp7oR7YRCo+jSOTW
         wNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762488942; x=1763093742;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj+8GmSM3Ia6Gzd6SNE/MpKX985VHdTbB0W6OfaqhfI=;
        b=I7RsDvrfiJ/Tqe/2GLho/icKB/BYMzHx2hyWiXRovd0AL2VIrwPTNKBrrSeAW3SaJR
         NJmGlrEclMztkggm7zew2t1ZMhB1EU5IsMZ5tLa/kGY2mf9AhTQIJYtwH5SggTb8iBDo
         vBXSxKQF5ch3Owk8JAgXWBTvnfZ6Ozus3Zqg/zOXQsFp/Z+0Bq+THLyKVEnmQZPgwevj
         Jbq0E7LO3pgzwAn/uLdywZPXROtQqrV2BB89Pxv2v77jwl0n7Hj5YMJCJItk4KGelYSh
         wfSG/GgZ5Vz9y9yFjTxD2+rWT089dsMNAdLoZmRSz12H9sViMPXTO7bJeh8a5nscQsiv
         gFyg==
X-Gm-Message-State: AOJu0Yy4IJqTLxRQhBZVfBP2msdWaa7hoF+nOnY7s/0mzFCOOcO8/o94
	6MAefAW46hlI1WgiDf4XxgTqkHwM/h0lH419GXeyIjmlG8txNNk58eI=
X-Gm-Gg: ASbGnctoKGi+Px5FWGrujCZpj1AjbPBkTKQKsT7DFQe18IjJWWfG0JseODpFqb7FtYR
	Pfawk1Ax7k0FcPK+wH4FI3iIu639fvi7XvtySy5Z5WmHkaaEjgy9+ntRE7jsRR8lc3IDvaiUmlC
	NOmP7vcyaGg/9IndeBfl2DyHJ/RzIo50wYKbl1YUo0oVjccwlo+rah764pj/FhgjrwfIK9q4g5I
	WSLoAxyg7rBujW7XGwE5+Z+14O+7ho8zSbOGWq6sLuukjVz5gLbaQQ21HgWG1GInBc4EEMUQobX
	QU+eygT1uwJdWn24l+Hv8e5/zHuZnkpUJwtUCpVByvlOAOCk2jHgG4RLF01hRy/7cPrNaTe2iZX
	T0oamATJkynubQh/gjUqtPKN0LEwVM7FBIvJnt0MY4X9P2HhpIufc8EVTma481sRNaxWfxDdqFl
	i33gr4EknDHwVnIhdyMgjz9c71
X-Google-Smtp-Source: AGHT+IEzjEoK8S6J/aEgjAs9AcxFaSRoQT0f4txlhxFvGjKYSeDwy8WxD6AU55k6nYwn59cWUNWI8w==
X-Received: by 2002:a5d:9615:0:b0:887:732f:6a96 with SMTP id ca18e2360f4ac-9488909c500mr217157539f.17.1762488941614;
        Thu, 06 Nov 2025 20:15:41 -0800 (PST)
Received: from [127.0.0.1] ([52.165.213.178])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888d94b8esm57834339f.19.2025.11.06.20.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:15:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next 0/6] NVME over MPTCP
Message-ID: <7f7d6334-a3c0-3458-b361-9bf15d8c76ef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Nov 2025 04:15:39 +0000
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
net-next/actions/runs/19157587244

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4d=
1bb0e3c51a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1020727

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
