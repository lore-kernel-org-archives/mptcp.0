Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB02811E9
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285828; cv=none; b=bVg823rTj1DEBDCJGyrkaBgRPDFGPHzNvddCgZ2DzzBxp1VtsxVlwywnuD041tu16Bv0o3OzQViyuYCS8zeF/lBIVzRmX0OH3OyB2FMkp5X/5R4bp/SavhnQgVqADgGBS5ydvaOvrecm7rnCfsGmDpiV6jOC8iwhjCSl1UxtVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285828; c=relaxed/simple;
	bh=WLs4UcMbhiqPGENjTRxcKgFiqr1nupw61DxkvuWzBfk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=mCN9A7KTA7rcdi2SRkeNulKiRoXRA+GEs8aXIomMyOA+7JIZPOQd3HxqLh0TxpeMj7qghW2HcmWcEg8c/n1+BKVC+etlCLf5t+ye7ZOJihFZhsX316CTbIhgjdF/Ny63YYKRsl5zGkuRNGNyU9ZybRLLHk0n4pOk1sDL8ZXkHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFxbaHL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFxbaHL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6BEC116B1;
	Thu,  9 May 2024 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715285828;
	bh=WLs4UcMbhiqPGENjTRxcKgFiqr1nupw61DxkvuWzBfk=;
	h=Date:From:To:cc:Subject:From;
	b=iFxbaHL6FijMLbKK3Y/KAbrhGGS6PfVDXPwaw7HtZJbmfpApteZH0f6n2bfWddk+F
	 mENFnrK7v0RJHIuQq39PtxZZZ5J5p+5N/Osd3w8ubeDpAxHyqz2QfRUV+QXYkpAM3X
	 0b4h6CM6RNDL+N0/88DxCNzDlTRa/z7TGk8o6BY6gVxskBrJKPp32EzrfvqfSC1rxL
	 rVXVtEYRfAr2TM4tDTP/+u7wisScrM/CUKrds6qjqIL8kIgMd3dkGgCVllIukS2cZz
	 C+rJGZ1I3LKd88eFvbai/7KP5nvPmZo7iZTwTiwMObdgYZIWFabEoUUaBAcDzRoCYa
	 0WCxVPQRBTnHQ==
Date: Thu, 9 May 2024 13:17:07 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev
cc: Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Subject: MPTCP selftest failures on Fedora 40
Message-ID: <5464ef10-4c64-17da-7cd3-c819af2fa837@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Just a heads-up, Fedora 40 shipped with a broken 'ss' command which causes 
MPTCP self test failures.

In short, the "-i" flag is ignored by the 'ss' command. I've filed a 
Fedora bug:

https://bugzilla.redhat.com/show_bug.cgi?id=2279920


- Mat

