Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047681F667E
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006977; cv=none; b=HBJDFZwZWWLRzyIZ/MzVDaZ1CaJxDV/en/26tuKOzVxlKBlHWJ7hQQPI6oA43lJz8xnqKrrqOz40E6hyQpXYfsSLtBlPM7DNlk4kk9neBCFxtvuyhezb/5SxkChmrncuZJaI8Uil8DVdy/Jassgf/j5+51nbc2DLit8opVbodg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006977; c=relaxed/simple;
	bh=AH534XInlXRDTyMfjkqhFrCPWbTnFTZ6uhB9dBDsv6w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Xr2CMBUdi5wTwjXuSYfCqqrQapR4p/WNH+LYddJhXrrcSULTQbmr1XagHKztj0EzLy5/e+YWSa4RYo4aIJWMIVC6/7ZuCKAC5eFNxoVXXWZwg88o/S2nBgFJUwQLmav/ayc0sZdaZYAxCVdkuWwqAVMXImp6hRjrZeruL3pXla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5Qh8wNC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5Qh8wNC"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2e3e4f65dso50744517b3.3
        for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729006975; x=1729611775; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+/jNLZssIZnMOJmUOZ5NhYTJxcrZ8j+WYVoRCYsJ4E=;
        b=Q5Qh8wNChN5cg0vrn7wy0kj7dM4N7C1oiMUjF3C6YbGyl7v8dLxnZqRSE8Qc88h25e
         FZAcW3FbwLdJ+xPAccKrsF0vRAX8mvFJd83Gl7NjMhzpCacDTmH2+ibdMSQrGOsmff2S
         Q+dLdWnJ2O1zR76K+yUoHVh0vIMj8tV37yEfWTqDhp6xWR0xXcPCzAPsNoK7fUtHexSr
         wyN8QZumYoWt8rlmtws/bT48917hLM+2RrLxX4pk8APFd+iWDpnZRVkjeCrdml0rUx5Z
         LmX9slxkSaKZbVPKdACBrzA5PU9Y+5PqsprpJ70eCn5IbwCRU/yyOvwhcuD7z10QbDQO
         956w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006975; x=1729611775;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+/jNLZssIZnMOJmUOZ5NhYTJxcrZ8j+WYVoRCYsJ4E=;
        b=ksNYzunGGrPeN78WMOZhLEyMfvn8+QtVkuZLVU5E5dKqXm+3UliWk8IvYDIMqsA123
         BhfckL0hYtZvtGaHnGhmhIHIofq6k8meqhmvsAGqU/65WO3iN8D71inwYdmSCMijd4dR
         jn2boUCe1U6aEmgBVlityTraruATBrUE6w53jBaav/PFnUFnYwQk4JQKpkHAVEraDMTm
         jZXkrvYHLetJZG4er28k/RS3PvI4y483XN3x+Q3Z/abdPt/tawWH724OTy+CgngnSHw7
         /py2k/r7xc/F8MIlkZZENE5E3ZCDBnF0MBtFFOkOWmSNybzocl3kfl1eD5/eazMLluNu
         /UYQ==
X-Gm-Message-State: AOJu0Yw4ACdG2fLp0gbOdCxQrt00eFvIs8u0EkK75tauI+cCEymDpOF5
	/NYKoQTLmnyguH0bOQb//IepnY1HULgcpeKK8AixMJoEJxO4Q14=
X-Google-Smtp-Source: AGHT+IHx9z1xGK44QKUrVfJsT4UYWRZ7bb5rGL1n/tp3oGyp+Pytoy0haDK8JfHj/7+o5cYWp9LlJQ==
X-Received: by 2002:a05:690c:f96:b0:6e2:12e5:358b with SMTP id 00721157ae682-6e3d3f7f4a1mr11018727b3.4.1729006974844;
        Tue, 15 Oct 2024 08:42:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290fa71sm7842856d6.27.2024.10.15.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:42:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241015151737.4111686-2-matttbe@kernel.org>
References: <20241015151737.4111686-2-matttbe@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22add_mptcp=5Fsubflow_bpf=5Fiter=22_v9?=
Message-ID: <c2448b98-6c49-0b77-5e28-a7cc4a46f833@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Oct 2024 15:42:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/11349477339

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/3a=
3642f20e95
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D899379

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
