Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0519C54C
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139451; cv=none; b=itAaxg5BlzKDkYJcWxDQXC52/UbxUfhmmt80FhODppc6HBk1W57/Rc2RtyBo1JO3S6dpf2QqsPSwn9RNMCFZS8+BBQK9Z+8bsHxcomqeZ6T/2rVkDWt4Ki+aTgVzvJcgXfBY106rtq5rPKfFfZR/PLdsav7jyq4ihvyQr5BHUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139451; c=relaxed/simple;
	bh=Q/Uh/Ox5+GMQvT4XZ3YnTUBPslQ+YuzNFR8X7mu1OYU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EFXe7Xq68/5d6eLjREhBkGNSWF3Fki6pqVK1uTTGOkaCDM7p9sFhHOQxYGUzZvV1S2atLZ9AHkMFLn0O9J6Rei9zbSndbi7Xa6Gu8aqVTVouD2AZx9YO1eEs3QY2FiLJW0COZ6Bn3DXrU3SWTva2wcc22Ppk6Nz3DHQPnCHXZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZoNUN5T; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZoNUN5T"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4581ee65b46so6502601cf.3
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726139449; x=1726744249; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHSG+D8K7wQuWLl8vsLRJV+BYc2+6R1c2vg/v2ezMlA=;
        b=gZoNUN5TCl+N7AWPEqgtydGAtJ3g/Q9dCzbL/QQtbX/JsAqnx611VTrCiBfcW7lHYB
         gdjvvTyEpHtA4pUKQG1VWn7wJUKjkYfRrEB7Z/J0znN3mNUfiAnjClaGS+27Kpii9D9j
         CBLNj/vIQ1/hMd4QUNN7ePKAueY8lADo56CmP+lp0FB53BtZKc80BamoGUbsmyKZgmPI
         7Z+FDj0KMrIIfdd2aTKnOd9g9+Z6RO40pQVELLcBEQQ5MObeCdLJ+MHvV8r3Krwew25m
         yjaPOfiXV01wgbi7b2GbgTu1cYVuEiFNnA2wQb7nifD3BWFMJLf1JFoKIBb+Yk7PFgss
         8Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726139449; x=1726744249;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHSG+D8K7wQuWLl8vsLRJV+BYc2+6R1c2vg/v2ezMlA=;
        b=buw7ptLmJLYPwI8fwTBkgFgSlLqJ00IA69KQEkI7xlyDwXRnbm6ERdQQJZqcGGMI7s
         QKjkgHYu+rt5row6lepH+PMDPBwYIV+tigA0LIrVjk8TRNGYe8K1AzqoBQ+m2x8CQMBq
         /ays6TxjfX2MzQRrTek422Z5oX51WKO3wpKEXU4pZXgZFR6L9ZePeAbDELBfxXZEnvrj
         spwUFNZN/Cdmfwj32om9p0t/4FAGgRf7smVBvUp3kU2Az5i9R8sH95wiO/mu1TzdvmRR
         QSS8eQcoH+QAU5dN8WDbOvfjBjsUJrGT6p1n5VptSPS/10POCmyo0Sso1x+HmXmW9dr1
         qkHg==
X-Gm-Message-State: AOJu0Yx0yCLqHcKMdJTW5DRLCvU6whitvtwumx6mRDph2Y/AyPt2pxRR
	Zl1aYjbijB5he+tZra5R78q+DVj+iT16YUof5qpbrwbn4iO+kza1cFVd
X-Google-Smtp-Source: AGHT+IE45d4d3Cu6a8BNqefdGlVdhgBZGPl62+yAq2tywF0EIMiehKJIciRc0qvrUEaREDR+4RJmMg==
X-Received: by 2002:a05:622a:15d3:b0:446:58eb:5ca8 with SMTP id d75a77b69052e-458603266ccmr32884221cf.27.1726139449088;
        Thu, 12 Sep 2024 04:10:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-458320392cbsm39160951cf.61.2024.09.12.04.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:10:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/5] add mptcp_subflow bpf_iter
Message-ID: <46ab09a2-898b-5600-7240-8151ce0d4799@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 11:10:47 +0000
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
net-next/actions/runs/10829533095

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f1=
2243725ecc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D889689

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
