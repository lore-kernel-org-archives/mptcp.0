Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C23939A6;
	Sun, 24 May 2026 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624579; cv=none; b=iXK1pAADRJT+2cCo1Z6ZyFdWim91+qZgMmmnag2sPxZUSBSacZih22NNZAbI79kSQCtUvT9edncgO4Y5nGWXWisf+tZyZ+nOMvC5Z7dlfrycmPVnCH0HfAtRlBpiGLeyqwhi1YFTyY21Hq7dsRVzo7DbomwPAIamyZXDbGrzB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624579; c=relaxed/simple;
	bh=iqdBp1SBe9s5B8xK7xryHGkN3EFOsiyJRhWFfYHWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJOxFJ5MOyJlJxIOAEU0Z8FQ1C7zkxAngrhcTMPeLMt+OdWJ9beEYL+VhdBnDhGj68hl26gYaYZzidHEu1zj1uzaxfoAx5GLg6rJQRmoY3+1sGKKKbkAfDrwaB9EpBgEQju11bMPjSwcNuy48KEosqY0t78u0ahW9pi/6Uv/IpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9fuugMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9fuugMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB46B1F000E9;
	Sun, 24 May 2026 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624578;
	bh=JzucgvGDuY3nnjHaY/HehPAaXtFO2Zl/ImV4s57IpW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k9fuugMp55DPOl829LG6koKXKRf7SyE3JJ1nRd1z6HiwqxPX3mTKNjL/4R08Ts1Qj
	 bnn+SIEfPsbPHUgG0YhCCoZsphm9omL6c7R/MN41GL6+vgqoQXT1OfDkd7+aBrOAE2
	 OpmSplBhy1Ew2ESN0G0R7kZx6jnK3TIhCP1+XWNt+JCwlkgPtFe5DsvWBUM6dYlZFP
	 nIX0MPxzEOjTTxwUVHxql11Gsoo3fZvEeqXhgmmoxNOHoez2IA+9SFbg6Ms9RlqQ7q
	 oLLdnZhzeE13lzqxRBlB+yWvou7iHWO/VGSZJz5hFLzuA5UsgZI9r4gNAw/vZ+VfyE
	 mRvYp0fJn6Lrw==
From: Sasha Levin <sashal@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH 6.12.y 0/4] mptcp: fix recent failed backports (20260521)
Date: Sun, 24 May 2026 08:09:35 -0400
Message-ID: <20260524-stable-item001-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521030845.723267-6-matttbe@kernel.org>
References: <20260521030845.723267-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
