Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0C3D953B
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873688; cv=none; b=QCvR1ljGwf3uLFLIvVoeHnMxLOOX8Kl1GN83KK7P55tovXiXZD/6Pv4vWMNSjHjFD+YJD7I8Q55AZKpR1fvCv0oaxBD6dYY8U3sEDYlzAYQmYLx6szjQYNuqu1Aiolk4HZ6t9bsXZs8uu6eTnIxNVH1ZWvrZQhgXSC26j6ODAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873688; c=relaxed/simple;
	bh=jZ+vCxo2tPQgsa+Y+is9CyeqOYvUKh8pzveVJBtJ4yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhUIGqokTDsj36iyhgFQQRtGcvj1IjeB/8MQ17NegrZZq+oqgsHJCVpx61Amqi8fUuEBF90yWDPU2+SjkmCHlpEUo5g6gRvRXUlUqQwAGEpPBEYV9/SkpAJ080MV+HnYn4TmvIiNlI1sHpunMHD7doJW/9gOKIGe2wlX64KFl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6nbQI0g; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6nbQI0g"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c718715fso4376867b3.0
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787873685; x=1788478485; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZ+vCxo2tPQgsa+Y+is9CyeqOYvUKh8pzveVJBtJ4yU=;
        b=l6nbQI0griwqerijXfif6ISq+r08WUKiGyqqrXk8FgQnvyjsuddS4F2pRqjwgrAzVx
         qpf72Ju2vV1kgt1a1lIm8rcd7WMK4sKcxrjn+t3ANbMQ/rU2P5L+0WmwPNPqEAcne/Xg
         JGC/EEhTB9tSWSpD226qAvUiqj82y4/OZ9+M8EBiMOJu8CwjJWu1oUEY47Apg9lsvtZd
         KYvGunar3DGrCRKbwLfoLDJBuHVNpgew57LwvC+h5JTfeTSxZDoHjCaR8DB3ZVhQ1EoD
         oHr2ZUY7bLs9smuRd/8qaiJzB2ZPFktzOwErL3PMWbAH87QjeNku/Kt2t1Tc9bMBZcBg
         P1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873685; x=1788478485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZ+vCxo2tPQgsa+Y+is9CyeqOYvUKh8pzveVJBtJ4yU=;
        b=JtlTRO84apt7+INjY8FfSMAwCNJqKg1jias1+hPB74jWugQVnzF68AoGL4kWgIWjKj
         ZnXWB1+YjVVyQHD4Ag4GEOTW4oo9cMXiM5iAj+mYK5gMQEgj04k7cWB1bPlFSAHx2N21
         F17NrsheJxVZl8UGH8hNZB7cJpNlS0cBdbBcAI0+/eTuOzYQWp1wy3LQDKs1+6ywOUQL
         BzN/ReWCY8Vr23HHE+OMpHghVPMx1KOkFBac2wHq8xwpSHR51lv/ku8HbHqvDn7mMFGH
         wNUXeScqFt4fuHkYTecNV6HoI1MCbLrkKnz5+q0fGJOM0QdzIyjHC1cPElzrzkidfaVf
         qOOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjhCxdXrlGRzfP60HlZVEBH6aZpZWCT1+SGIa4uHzP1X5BPwX5WxwwDl2Sbar194pY5rR4hA==@lists.linux.dev
X-Gm-Message-State: AFuF++nFVn43KqCuJw398tZLuQk7mjB2hBTWZH40HKD/zHmVaG090Lhg
	H5YYwUn0chKeRwJYikh6bOYEc/OoJ6hI3vGE4UVh7/oIbCXkt3yI+i00
X-Gm-Gg: AR+sD12Bd6/IyQ3dmMeEPTBc7zmDuVppaH0AN1vKLt93j2j3W3adREiyxgzhmgt4K4l
	gFneuaWefxWDguZUjDVnXBTVH5g1IejN/uMOE3ejgzDcMFUIE9NWDYMRRTT8ydKKrFgPiCQcQpZ
	edizP8o/IsgYzQQ+vASHSr9VBZVub7yFgaolHNGyZBgS5ri8farVbx/d1hCXHmrpo74NSVtqJWJ
	qEu78pOMhSBRw0XFOC+NRPMa0ni/wKS7X0dEtDxIQW1E54ujKBksB38WFnuNnfuaIb6jyJ1Lecq
	8Sgq/ZAsqXIJwYfEnfsHZ0SmAkb6EAtcptv/vm3WL/2nnBG0IhwlTZMIwSMjIo9KyzPlAuQ4Ko1
	NFVpEv45oeRo0sfK2AEr4nKLD6SHXaK28j8QqObmCaN7GEpwVUzn4HVE4n+2yWO0MHdMIcDcwsY
	uj7SBJKqaWi1lDOE/HW584l/+m6oHR/E7fd1Fv5OiTuTBp3URuHUj+wfKEPkinI5TQ2Og=
X-Received: by 2002:a05:690c:dc8:b0:803:6bb9:1753 with SMTP id 00721157ae682-85d6a2e0cecmr14384447b3.21.1787873684925;
        Thu, 27 Aug 2026 16:34:44 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b5d1b0d5bsm18192217b3.22.2026.08.27.16.34.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:34:44 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: wpasupplicant.patchew@gmail.com
Cc: blbllhy@gmail.com,
	mptcp@lists.linux.dev,
	AutonomousCodeSecurity@microsoft.com
Subject: Re: [PATCH net v2 0/2] tcp: fix use-after-free in do_tcp_getsockopt()
Date: Thu, 27 Aug 2026 19:34:37 -0400
Message-ID: <20260827233437.76323-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <022399e1-16bf-3a85-52db-1e3cc0195f2b@gmail.com>
References: <022399e1-16bf-3a85-52db-1e3cc0195f2b@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 26, 2026 at 05:50:09PM +0000, MPTCP CI wrote:
> But sadly, our CI spotted some issues with it when trying to build it.

Thanks for the report. I will fix it in v3 shortly.

Thanks,
Cen
