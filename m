Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C071221FBD
	for <mptcp@lists.linux.dev>; Fri, 23 May 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999322; cv=none; b=EL+LeVqaF6qHkyTc4I+ZHwTo9pvOFKNoQ2/37PB1vv8M6XMofVsN2pVCrZxh+H9+YTF62sj/485d2x2o/KB6gXs0MnQYtHkmOvhID0uSTJFvBzSRhkFCNCI/d6kyim9A8M99WcGgENiZ3+4Kdopb5e21xwDejnVLyOO2LUcwHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999322; c=relaxed/simple;
	bh=HRZY8nGDspugFFGgZZlyb9DuiWk70PoXTEbTARV8PPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEm6RjCkNuDzdebQUOq013X3nO8TlBPtH1BtX65D6XrUcT77r6vpaa5korO6DQ5A8oS/IW3DejFEliAICX/QYQZ5uCJKDxySwhoOVmJLrLUYx1Ls44gbrzjpjlgCU/EC0h45Ulj/oNyYmV3jKG2Mwj0Y0IhUMSE7GjJO6eQGi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqYo1kIO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqYo1kIO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b1a1930a922so6107358a12.3
        for <mptcp@lists.linux.dev>; Fri, 23 May 2025 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747999320; x=1748604120; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPHyaSHkvCyCPTXv6u+eDabhPxYYP6Plc2ufQ4SwqUQ=;
        b=aqYo1kIO56qLryemdTjguT7FwlMEdiPHArjfU123qgzoONfnlUDFNzAcHrG2o+ARo/
         wnZZ4PRXB25D6ki1vQzpa6eJsUoyh8MUZwj00AaX9wy5Cop9uXBrqLxaYzUwHje2uGak
         J1CDlp6v2vl+b/5Y3TUyjsJEycr55vmXyBlFIdt4PZqaGgy66ip43XvRJ+K8aquxUpWP
         0lPXVtdMnSov1yLu9Ub1zZloMPAIQ0lgBTXc40q5p2TKqh4DW33inZZHXwXDG/+YtxHe
         8h1BvKuF/7WgylEY5iEPH10+YCJJg30AbeZS5JGuYdmjLrozopX6cK+PhQ6FOpm6CRWO
         UZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747999320; x=1748604120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPHyaSHkvCyCPTXv6u+eDabhPxYYP6Plc2ufQ4SwqUQ=;
        b=iIipO5Ipo5aEHE0Bq2CzGPwPty5XkY49W3n6n/8SyvWaWSABxNSpu+ObMOQ60BL/Ta
         n+yAWAPPop366kLJZN4YwmR5z+PS12LTt/ouV0OGo6rS7T2xTUFmdd/ph18bEl1PjS5M
         xWKGmZykhvM64q8LsQ/i7B+0rIy5AFDDvtsFWpeAnNJJIxhXRAMeNR3Lwy0IO+NDdqa2
         t9mrpQ3/tPZi+1zPhcRQZPV1SiE3KHzXAtQlf3SFPpuvHvqtEaM1KEK2JbgMmjCieuaU
         9UV19twaRUJj8Ad6hBUVHj5E7C9iqyzP+USY/quby3SZvdtNI3JDpUzaaaWGftlSWfGj
         m7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVSpSXaqn0QbjyvEC8s7GCKM79rJfndBWmhYKq6Moscd0M8wbTMFKqPyHO4CY6slDxTbkWFgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqbMaNRIvpau2HFsb5QcwKwpF4lxczDn1/PFr/kqyPknaTjpOm
	dXLq4OtE6A4NZoV9j8paGQQRTcqGVcv+uQ4NO3CwDWq6s7GUbEFCSqEy
X-Gm-Gg: ASbGncvFjxpOZkSciF2IgDmQt/43oriDWQKyZmeF08usmfW7SxwSVCs/hNHUIwanTx7
	rXVaMBKBgsn9RXvFWrVGJMPcMnNCpjTRKLdWx9kL4CmFw+T5AaXgBdYCvkU8nXq3B8aza/2XyfR
	YxCI7MWqnJxUyIYHxkeYj9kn/WzIEvv/5LWiWeLlqo2QcGR8PZUXgRtKNXvyHLdifmvXPN4x1ig
	3tmZHJdPL9TIieHy84mUGQ8rjx5hDJcdHdBjvyRHbxAneME2n91Px0/Ee/r1GTH1iJDp27jT5dk
	iRgR0qLMuUUZaV47HbzR6L3IfnBU3V2QMeGrzZMjLs63pXcItFSmXopU/Sv9/xF3Nf0=
X-Google-Smtp-Source: AGHT+IFtwdCBSuO+HZMryb8qVIPtiyuYMxUouiREvqVTSIMkYRjCXn7ITim/JrYUwPnsayMfqr4aqw==
X-Received: by 2002:a17:90b:1dc9:b0:30a:3e8e:492c with SMTP id 98e67ed59e1d1-30e7d5be2ccmr36427873a91.32.1747999320086;
        Fri, 23 May 2025 04:22:00 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b2da7sm7127825a91.9.2025.05.23.04.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:21:59 -0700 (PDT)
Date: Fri, 23 May 2025 11:21:52 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: move wait_local_port_listen to
 lib.sh
Message-ID: <aDBaUJJegs6v1tQT@fedora>
References: <20250523034433.1373-1-liuhangbin@gmail.com>
 <c8455e63-4c25-4610-bfbf-f6547b3ac834@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8455e63-4c25-4610-bfbf-f6547b3ac834@kernel.org>

On Fri, May 23, 2025 at 12:56:01PM +0200, Matthieu Baerts wrote:
> >  delete mode 100644 tools/testing/selftests/net/net_helper.sh
> 
> The changes in MPTCP and others look good to me, except that I think you
> forgot to modify files in tools/testing/selftests/drivers/net as well:

Ah, thank your for this reminder. I missed this directory. Will fix it in next
version.

Regards
Hangbin
