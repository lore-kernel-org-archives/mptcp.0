Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E650189F20
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209148; cv=none; b=BdBQeFxP9Gf9rKWVRmGeXw+WWvcHkmZbwUMdbbyXQFewe45rU+UmAu3mhgmuYRJHE2ygyRVSinM6mmw1Zevr3Nn0HJ/5yXSktCaPsfMXUZCEeoLd3lOhUAFh5YLX5PhHxhY+BQdd7HVUx0z6Ai3zWi9MdmRzwJVzPJl8whFyjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209148; c=relaxed/simple;
	bh=ZD6Jk3VYmcAEVvNuKhOMr3y2n9JxI6TJW1NbBazyK+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lOXPSYiKC6/7EgV1i8WkknYJV+M++5gpjp2lnuk6vhLFGAkh/8inDc34Rp/BWphhvrO8mOQMTsHVX0JbuCVVoLXk7TKlauuxPoID1fSDyberNGDl41pRpbwDeRoG1mOHbcgOkJFy+glJFMv+CNwYJsB9aUCqUSA2HvILvhurwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+BoJuwR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+BoJuwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E959C2BCB3;
	Tue, 19 May 2026 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779209148;
	bh=ZD6Jk3VYmcAEVvNuKhOMr3y2n9JxI6TJW1NbBazyK+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=C+BoJuwR5I6hmDGulSkfnA1VYJUAAW5eZbdDtkuElNOi2iwwZICXeulsavNCeDVSr
	 v5ljPFwaEZV2YJ+EkWGjVx67kgVJpw3xNyUIorpKvGI3Fu6f5Lg+OD7MTXjrGCg4GF
	 3fx2FwX5WrbhiM9oIvIF4AxOdPCt3AT7CW8rOJ9J/ubAzHgLCMvN2IPAwvLI9fGQnY
	 LCyO0Dvovl2odGG7rQEpzG1wrtIw/j+9bDy3ek02B9nnpme8+xp7fQ4W1GdLFR6pmZ
	 qTMb1qP1nnVnC+u4msKyUzF+iNHyTLLLrVmoPGeM7M1525DwHKFsAjDp9uoaJk7xf1
	 z4OFbCo7Xz8HA==
Date: Tue, 19 May 2026 09:45:47 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] Different time this week
In-Reply-To: <d53fb871-26f4-451e-a52a-80ecd2bd1776@kernel.org>
Message-ID: <1e3eb6cf-5157-d1da-3ee7-1c6a09b1f8ec@kernel.org>
References: <80db88ea-1e7e-4417-92d7-e2ddc12400af@kernel.org> <77f0e560-b51b-9cdf-86d5-a79c7679805f@kernel.org> <d53fb871-26f4-451e-a52a-80ecd2bd1776@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 19 May 2026, Matthieu Baerts wrote:

> Hi Mat,
>
> On 19/05/2026 10:18, Mat Martineau wrote:
>> On Mon, 18 May 2026, Matthieu Baerts wrote:
>>
>>> Hello,
>>>
>>> This week, I'm not available at the usual time: 15:30 UTC (8.30am PST,
>>> 5.30pm CEST, 12.30am CST).
>>>
>>> I suggest either having it at a different time, e.g. on Wed/Thu at 0:30
>>> UTC (Tue/Wed 5.30pm PST, Wed/Thu 2.30am CEST, Wed/Thu 8.30am CST). Or
>>> cancelling it. WDYT?
>>
>> Your suggested 0:30 UTC time works ok for me.
>
> Great! Tomorrow or the day after? For you, on Tuesday or Wednesday?
> (Wed/Thu for me)

The later one is a little better (Weds for me, Thurs for you). Thanks!

Mat

