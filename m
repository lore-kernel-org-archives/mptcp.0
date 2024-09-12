Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86F18BBA1
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134753; cv=none; b=YPIJOLlRJEvl/HW4dcaJr1UEzbArvy6zRiBpfH0Ji9qh/mJ5OIsY1jSZHI/T5i6qimqH8wTgTwvlV0z1YI+DSdzdmu/r4HrMDTspBYgEc1xsCllkZ0f4qni2ANZ+u+udrc7ks+FN9OstT1KbdGyMdLG7Bc09VHoo8EmxrCx00KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134753; c=relaxed/simple;
	bh=oDfRpPISj0JpXtkwlrNvZbAfP+MxXahhbvXew450bwc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RQ1QcUjkXfs3OxImCbsz2HcTxCeI10E6n2TiKZ28yrCqogYI35BXCgzssBYpn+tBzSJMmUFrPIdT+tN42T6aY04lPaWkDxwVGDbuY7QyeeElWgXl73WVn9aJEGVavlZHZ8/sU0UP9N59QJbK/PyKgxgorW6mkLgm+hJ47lOr9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwmsvqWz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwmsvqWz"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e1ce7e84so518680b3a.1
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726134750; x=1726739550; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSXG9+jYDay/gAfhePb52z5KXYXWDu3IIc8P6X72cjQ=;
        b=ZwmsvqWzQuVfhVh+ZkQXbbbs3m0M5yVtfVFzHn40bOZkgXXcvsFQaEdbAxoNm5ohGQ
         8k7kzkGinWMucsmyzFuAVQyGhqLlPIg72aME6LM97lwswkHd3Qf1ogiSQL4ORTP+aJsg
         DA5BvRgWcKF8G2g9tSAsAyPlV3oKXLYXMj3pBQD2V41ajRbxiNuZXMaBhmSmC4zA8SZq
         c8hSynPTS485dp13i3GiFtjIEaM5H2Tg4s8yL+c9uhXGnexhRFh3LhHD1wc9gA14PN4R
         JaqbglmtOjIcMgT0GNO8bzsSDjRCTnk44u0FcqltwwlICCDdgVS9VWITzCXero6CA5u8
         MpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726134750; x=1726739550;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSXG9+jYDay/gAfhePb52z5KXYXWDu3IIc8P6X72cjQ=;
        b=QUY1AHiNsSQMnfZ5nBWIbgpSDr1uiyjnCcLfyJqT14h6AFN4WBEf0Ia2Q0xcM/6qf7
         lHCVu0KCD3QMDjevxf86q5BEAXs1aNcP0LYgq5Q6s3Abu84I/j7Vmqau9bsLAhCPWb2b
         tu89C1xpk+x8Wc+YpkPBUNwsEbNae2Nbn1xtQwu8ltImRN2tGI089WB5grn/aTKDR/CI
         97QEOCtGvEI3eFD7qwMmFSG6hTzYYFd1aOiOhl2NcA++1LUbE70rl2MUcGjsP1EZigyJ
         JBMtLz/1rTCYvdv5NXvExsXiSCjDAC1CzJcJQnMaxlHhb1DZ6CMBJ6fqqunywr8YgGe/
         +jiA==
X-Gm-Message-State: AOJu0YwTQlhkc0aqY4Kee2mw7Kq+X7AhmAvfo6dPWgCOYophoduBbIC8
	sgn6StWMoPiEMg3HTBNycSuUPcO9vjoczRJRHznDzZcSU56J9pN8EPns
X-Google-Smtp-Source: AGHT+IEOn8pql2brqFScoeLrxpPtEBPI7+HfwpktGnXkDvSmgOTAu7eu/fEXInquH9DMD0zY3PlxQw==
X-Received: by 2002:a05:6a00:1ad1:b0:70e:8d35:7ba3 with SMTP id d2e1a72fcca58-71926084e86mr3262140b3a.14.1726134749807;
        Thu, 12 Sep 2024 02:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.44.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090d11e6sm4228631b3a.205.2024.09.12.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 02:52:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/5] add mptcp_subflow bpf_iter
Message-ID: <0b731f42-6061-f819-7e7f-b1cd5cba7c2c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 09:52:28 +0000
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
net-next/actions/runs/10828370093

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8e=
5f73626f7f
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
