Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537D158DBD
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163033; cv=none; b=EaVoPqeCR3UPZVRBlUrczNQ5hE/NYSUmm54xMjNRYrJhSoNZ0ZIrFzCPdE0WR9HuuQcQ2T6iwF2qhnNeXrFKM2F4m/6zZqSpmQ69wzihUR6rW0bOVh6uM9AFXl8l86dFE9hEvOMY4uaopDYL/BqLXsnZfxBnOzVcb4P4a/OcQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163033; c=relaxed/simple;
	bh=/bddIuF6XoTcczOJqWwnTTDf1IpA0CXgyohBgmUbKnM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LWBdrgOgdWYTuI3eC1MGYenC1+kIth6wdWRxFTtHG9ydjAdaPg4gSh3g3ITzZ/iJCJD7B+JYD5u1PDHEDyCgXQTSFu006muaxfXp8rjiOe7fiQWxEkkeL+MeWLSlxq26WbtQ3BLpfZ4+aHB0ssyfnu8ztHI5o6d0cY+Gpd/QbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJMwAluv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJMwAluv"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so10976106d6.1
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717163030; x=1717767830; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++HQe9DF0dzDTm0DUgQT33Y3vbSFzFmHb6HPI9lRY+k=;
        b=IJMwAluv2iHCTC6bK+IkDZCD5kF0iM5ipwAYp+jAtZcSa/gWeSpA0lpx8iJnAq2nHv
         sMw44z/imBPb8xzMuMfzyCAW+d5yIBrwvvw0GKcvDCjEjCXY3qiOdQr7Su8mHqt4fybI
         3NbfLVDkVde6DFpPXoxTaV+0A0qwr0zMgeMGLZxKfJPziwsUTaR8v+UOLUsa+bjU9R4s
         +wW+VaY51kbYy/G0OWkYfV+vsSZtJFsQA0Beso8wX/zOURAfUjuvz5fHk6Bb8vGDyHyY
         5fKtuObmN7VRbJdnIaIjbneVVOsfECoNFvpAHaPLirKWS3G10e5lsnfD3mEL0qZkirqm
         /QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163030; x=1717767830;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=++HQe9DF0dzDTm0DUgQT33Y3vbSFzFmHb6HPI9lRY+k=;
        b=Sme2zG1Vw72c7Q9JFhbh3PSD9uj+CSMdWyIOcyewbsNzK1ibZrUJAoEO3i/yWfAI8S
         y5Brj82a7QZ15vzWUXehRtwQ5+O1fzI2Thl3BwmmkXiOEy14mX/kAbUGIl37BRRx929n
         w89IMTYrk36MHyIo81xPIADgiI5si/MTWNo++I9O8UVoJ1SxAYZ99m5Nu+gi9KP4kWZZ
         4L7D9FEKs659+dxTHrkFFgp1Y2Osgx9j8f4bF1xrr3S8SSnkDAzFVBNJAM/xPqOgj7//
         NU5QSlFPOptt4DAzcHSv1pM1dg4vVNZoTEGzg4ipuHWmR8FV0S4T86D9Hkc7oQ7AiFYY
         U3MA==
X-Forwarded-Encrypted: i=1; AJvYcCXjsoQbqzmMk0kqG/0Nu8NDC8Z5JVEmcc469OQ90a4HqegtFQBqnXtQBQxPaW38/GW43m5cIY04D/9DogtG1bJJGXNXHTg=
X-Gm-Message-State: AOJu0Yz3MXjW6jIU/GGFfDYsa2GCBtK41o9gr7mCGhLvOq4OJBsfGot8
	zFVmIRUMl9QKIRL4Mf9/U8Tf23dzsEfUnS76H/wytXxIPUuNZxiG
X-Google-Smtp-Source: AGHT+IEn0j6XjJhsnpuMRXWGeWlPQLAmZveIxjzC6yBrb4GJQ/9DPHKc7FRHk+nJWezesgs9TYlwXQ==
X-Received: by 2002:a05:6214:3ca1:b0:6af:4c7:2c04 with SMTP id 6a1803df08f44-6af04c72c88mr858776d6.55.1717163030422;
        Fri, 31 May 2024 06:43:50 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a7462f1sm6506796d6.33.2024.05.31.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:43:50 -0700 (PDT)
Date: Fri, 31 May 2024 09:43:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 edumazet@google.com, 
 pabeni@redhat.com
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6659d415c8aa3_3f8cab2944d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530233616.85897-2-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/3] tcp: wrap mptcp and decrypted checks into
 tcp_skb_can_collapse_rx()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> tcp_skb_can_collapse() checks for conditions which don't make
> sense on input. Because of this we ended up sprinkling a few
> pairs of mptcp_skb_can_collapse() and skb_cmp_decrypted() calls
> on the input path. Group them in a new helper. This should make
> it less likely that someone will check mptcp and not decrypted
> or vice versa when adding new code.
> 
> This implicitly adds a decrypted check early in tcp_collapse().
> AFAIU this will very slightly increase our ability to collapse
> packets under memory pressure, not a real bug.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
