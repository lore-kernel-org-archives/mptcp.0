Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0215A5
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054981; cv=none; b=Ppc+8x2co7rTuDA1DGlnlrZOw7ezhvFdUkFqOSfjuVvxnPiJajEKaTffhJo5u4U6hVQ0/Q19YEmnYyMV9QR2vEJCFfmUd4VF0/V92YD5C7xKA94MJX+MhdARrsmKBtomqLk6Pn0RDVpQxJGJM2yaF5ZN2p0gE+shGMLfrkdG9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054981; c=relaxed/simple;
	bh=WhVNaL+k1/uLZuZB1Q+yZWtsVnPpG583eLrfwjqRbuw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=e/RPVcqIP3mXMMoJqOvvkl9x23729S9Kio3Mv9wET2/FrdKdE8wTd/hi4OlRy8rvKUfvENq6qoMgsDyGQb3nmUoJSPZ/UJwczTYkW+8MYF8sW7L10gjnFgjTcp3YpXytnVzYprSzxbMIzhku3F91Q5Kpb1rXjOq5gxy2V1jbkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozFWnKje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozFWnKje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FB0C433C7;
	Wed, 24 Jan 2024 00:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706054981;
	bh=WhVNaL+k1/uLZuZB1Q+yZWtsVnPpG583eLrfwjqRbuw=;
	h=Date:From:To:cc:Subject:From;
	b=ozFWnKje5FhfsTJm+PD1vXT+J8P00d5j8C67V2iaW8w/T2tJigj2R5wLbajPwews6
	 4GDOqzKbNZ2MXA7kshPMSMvI7WauZL0rtxJ1NjpUesAAcqMjO3Fq1j1Lsz8/FJ7kTr
	 8jh2m3bBGXnN84NI4y3y+1TBbJmRgvdCfGHrAOoZHWEF9HXh0CV2mkQ4gUVMOjl6ni
	 goFhHUb56MfN90CVVfapi8I9CidNbMM7gNnoE1bWS2oKbrbD1XnGGLT+Z4Epk2Ztjd
	 q76liK9kMY20yKWl7TZY3IudD2waYGIRByQI2cf83lLkUmGtz8EQGWr8/RO/75pUI1
	 jnuCL5RYeVrOw==
Date: Tue, 23 Jan 2024 16:09:40 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev
cc: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] No meeting 24-Jan
Message-ID: <90ef2d9d-b477-8399-6896-80b65f62e1aa@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hello -

Matthieu had asked me to host the weekly meeting on 24-Jan, however 
something unexpected has come up and I won't be available.

I'm canceling the 24-Jan meeting, we will resume our normal meeting 
schedule on 31-Jan.


Thanks,

Mat

