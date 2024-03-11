Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83C801
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122789; cv=none; b=lF6EiIKrAQj5eg59LJaMETXPFSmhnP+WEpiK4bflRNNVYGprOuKWO9ELN8qx1F7FOGtnhWTt2cxaleAdXWnOLi6P3RRMG/zj05RR3ytlayg7ZYI7Kji0NiAMqKch7pbxzsWuxJXcykm9yeNTsi73ntVm8SXc5KY3pK1A6UvCgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122789; c=relaxed/simple;
	bh=NK2Ag5/aGoNnEiKB0mN4ha0Pyt465/1Y1hdasH4L3GQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FrNIYTbHSY6F5oK/02lHEtuGcpyEO2cnAPbLfGuvGx6mKdL+veKLOaxva7fNoE5TbK7pLjmUQq5z9ZXyEiWRpAgjjyFRxC19wcQZq3TdMXoKsNJPiflGjv8JbT6Ayytz9zjFlsMCdZaXmFUyEB1q+KwHUAFp8v2CPzeNQEJrxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsDm2U/O; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsDm2U/O"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690be110d0dso16541466d6.3
        for <mptcp@lists.linux.dev>; Sun, 10 Mar 2024 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710122787; x=1710727587; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1wX2L3+V05/lxZ4L0QS5txmI6yO2Lo0XMHDXE2i3dw=;
        b=lsDm2U/OYs5k/ry6nxK2vLmUdKR+rgFsZZ1hKpjRw3nrRhIbILsmEywdPPSgqtybBo
         Tfs13oypmXS7GYywXjAGMx7KyBF+IYAEiXIFSrvPOH8kAEXgWSPKOgKpL6Rd7sGNruDj
         Tu1woDwOdh6jkW6jhDP5fQ6kDq8Li7cog/m3dIK8jYDQF2/yxkyBU8S3arDRUO6DqP9l
         tZFtwwjoQgkxrEHnE22i5k/A/v6DniNCNFqnq7zzyCVkDlNsb7lBSdDj/CwTIGnJZkl/
         XfwtpJsrx4HThv8MuVi5kcT8XGY7xndaSopEyS0+M8eupdMnGq8ILCdouBsb+NdsUhUa
         TG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710122787; x=1710727587;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X1wX2L3+V05/lxZ4L0QS5txmI6yO2Lo0XMHDXE2i3dw=;
        b=H/DThIjHC0+lcC4qWJxfHn7w6UWGjdUFLwzWY5RpUooGbtnhE/AYoxHA31ro7Pun9v
         TkdJwmKUnxrcJKyBZIWGhLxInurWIklI/ruvhuffjCkYjU4iH+6Tlwv7OCm5sOTTb2s6
         Ptz6t+1PPi3UZ78WVBJGtH33vS1eWb4Fgzz4Cq1FfiAn9gJmO0X53D390zIO2eCy0bpO
         FzHIEobFP7KSIbNOuXegLRpkIIYYwL1CXcPeaewPI/uvJt23CSDNzk+7RK22iVmBQwIm
         flHwhr2UpKguHOKX8Jb4F00LIFKueFqeiMaUej3/fcWlepc4v6CR82WMWAn0uARgN1Yy
         KBOg==
X-Gm-Message-State: AOJu0YyThYwBVut5EvEp6bOHVHZfQMWSyq6Hd3NLfUKmtaLYnqxadT0g
	TcCetEwM2fWYp1kqgJifbRGrdT2kigXgHBV4a1mNW2QkG5O/GuGYEujoUvA=
X-Google-Smtp-Source: AGHT+IGfgpx8aEQKhAC2etbLoroD0zjDZFew2ciFDpme58+bYcYlAEzHFXd0Q/LrtZqd4+T5fiqwxA==
X-Received: by 2002:a05:620a:1582:b0:788:19a3:98f with SMTP id d2-20020a05620a158200b0078819a3098fmr6221504qkk.3.1710122786875;
        Sun, 10 Mar 2024 19:06:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.34])
        by smtp.gmail.com with ESMTPSA id pa3-20020a05620a830300b0078812b73ea1sm2277889qkn.28.2024.03.10.19.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:06:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <82de56f853e291af0f6474ba21a366c895ad8e5c.1710121590.git.tanggeliang@kylinos.cn>
References:
 <82de56f853e291af0f6474ba21a366c895ad8e5c.1710121590.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: netlink: drop disable=SC2086: Build Failure
Message-ID: <b89a46f2-f50a-7fcb-9a70-ee00a9f5c6a2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Mar 2024 02:06:26 +0000
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
net-next/actions/runs/8226639605

Status: success
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ebeb11fa85=
7d

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
