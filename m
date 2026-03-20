Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F235CBC4
	for <mptcp@lists.linux.dev>; Fri, 20 Mar 2026 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994046; cv=none; b=JKOAT7zq6zp7TfwZQ7RKNFp35ywOyZkhcA56/yUTfM/6olRggA/Aj6TIphSPPjo9CsSeobqk9BjZU+gMIsqZT9291jPiYVRRzdaib6zwvu49skqNqJVjv2VFpsjKy/rYauh8c49rpZBl1WseNgdOCMjmkTVC4TuUCKcbSuVEg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994046; c=relaxed/simple;
	bh=YDyUuH9NvNJyqsYiqfOe9UBRyHVsX9CrLcTduzu5JFg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZFqTi1A5PBXSpeW9WQrN2t59Dy8SXZzSd3MjD51OfvoKjyQ1tvtsqdxKZCIPI3fwYmR3/Up28nHhE9ZGcfj8MoabVTwgdinA68Q1/kAeeHQejSwdIVR6nDFDrDPUmMTk8ybMYooIGCorsfpMUhXcFA+OKEGui8e7kv2FrxCcYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX/BLbPz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX/BLbPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC55C4CEF7;
	Fri, 20 Mar 2026 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994046;
	bh=YDyUuH9NvNJyqsYiqfOe9UBRyHVsX9CrLcTduzu5JFg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IX/BLbPz8p6DCwzfhwrNQiqrDYqXSFRx9K+/ZRkCN2iZbF023GEYyQO8W+UdrTmYZ
	 SDJ30oBYFqKF0hDmo11+TS13XEXjTO+NPrpgTxbu6wHTiJo/z0BNxHl/sDrssngBVl
	 nH+DJY3YzACXBBBfl9jYGlGVlYQARpSqmzFDET7dLJdDlMMHCAZA4auD6ZxFOLkNoB
	 eHmUXVY9obXqmY1/ZaIR6BYV+6IYhoaXbOw8N5NEptln//9zJBtZ9IyYu2Q6/yf7Iy
	 D0gwm4qQIg0BZ5SEynVL6ssDsDuQZDeix+DcnRnI1vjVzpfe83jKC0uv2RSKu0Ztie
	 71RmEKiGum4aA==
Date: Fri, 20 Mar 2026 09:07:21 +0100
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
Message-ID: <d7e039cb-0cb4-47c4-bbd2-11d890c5d381@kernel.org>
In-Reply-To: <d229f43010fd00178c87d2acd78bc7519d3c516d.camel@kernel.org>
References: <cover.1773737371.git.tanggeliang@kylinos.cn> <347b9b69-7fcb-d7eb-a3f8-921d1a6060de@gmail.com> <b7ce3e8b-dd6a-49c7-aede-23c846c6dfc4@kernel.org> <d229f43010fd00178c87d2acd78bc7519d3c516d.camel@kernel.org>
Subject: Re: [RFC mptcp-next v10 00/14] MPTCP KTLS support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d7e039cb-0cb4-47c4-bbd2-11d890c5d381@kernel.org>

Hi Geliang,

20 Mar 2026 08:45:58 Geliang Tang <geliang@kernel.org>:

> Hi Matt,
>
> On Tue, 2026-03-17 at 14:15 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 17/03/2026 11:41, MPTCP CI wrote:
>>> Hi Geliang,
>>>
>>> Thank you for your modifications, that's great!
>>>
>>> Our CI did some validations and here is its report:
>>>
>>> - KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=
=85
>>> - KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
>>> - KVM Validation: debug (except selftest_mptcp_join): Critical:
>>> KMemLeak =E2=9D=8C
>>
>> It looks like the leak is linked to the new code. Is that right?
>
> Yes, it's related to the changes to shutdown_reuse() in patch 12, and
> it has been fixed in v11.

Great, thanks!

> However, I noticed that v10 and v11 didn't trigger AI review. Any idea
> why?

Not sure, maybe the RFC prefix?

Cheers,
Matt
