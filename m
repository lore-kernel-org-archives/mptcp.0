Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31B22B8A6
	for <mptcp@lists.linux.dev>; Mon, 16 Feb 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240296; cv=none; b=jKsnatxfnxaPOS4SP6z6r8ObYNFrgmpWeI+twRLl3bUQp1Q0uzZlcAdq+6r184P4TT8YrwCK5JAmX1CHqxemkzbBeLhcfm0hagfQiHBUXsUC9suWa3pPE5q59GZGjTitk6A4LcXlZ62MQHm6raEgfzWCHthwThWqqZn6JwL9h+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240296; c=relaxed/simple;
	bh=VvWYSzz9wFD0JmSFEUt9x7t5ctotmWIErS/2hnTGsag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GlYcKG0F//RfjPDFEmkU/b1Yn/VG2JU3q+12lQ+G5w5lQEOAFNFUWulSup4cah1jA3cnJFgHk6xbOyKaI8lHOglncdwWFr+xmfMP1/SobR6LCWO8Ojk1mJaX+hB2Fnrc7bUu13CagRGXXoBkDWJk76YVF7gZ2BBUVUiTzMdGy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3c+3Fov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3c+3Fov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B352AC19424;
	Mon, 16 Feb 2026 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771240296;
	bh=VvWYSzz9wFD0JmSFEUt9x7t5ctotmWIErS/2hnTGsag=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=l3c+3FovX3j7UMpG6otX66BBwe0ZqxCxcH2UBZl7Q+CjxmUf2mBaieeyVdsgMSkjx
	 HUNVdqVWCoMR0CgJ2jN2lady0Gme1Het+WXVqJQS8XdRE3XisnXMD7wBlvipju0zcr
	 l6d0F/HY8OkLIjtnVgZv3r1SfmKb3cHqg4EO4Vszb4cR3fRP3zUesqK+l5bZOFtGer
	 Wd9H8rx9fvULI5tnVMCsP2wqrQq7t7bdSQz8C+11b5E/nCkDzODP18ZavlLhGvVV+l
	 pUOf/BgxyEfe0NuE9czh+bO1Dirjs4wZNcO08IkeNUyHf8hdonzxPbH+uoNqh2jy3O
	 TYCwUZk36b+8w==
Message-ID: <e7540484-0376-469b-acd0-52552df59136@kernel.org>
Date: Mon, 16 Feb 2026 12:11:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Initial work on adding MPTCP support to Firefox nightly
Content-Language: en-GB, fr-BE
To: Muhammad Nuzaihan <zaihan@unrealasia.net>, mptcp@lists.linux.dev
References: <CACNYkD4A=omPgoK+EZGuid7=xk5WH1HS8nJja5p0N86J0j4uWQ@mail.gmail.com>
 <CACNYkD5yoQ6E2-dPbAjWPdQ4zQcOip2RwKQmtX5Dv++oYH8EsA@mail.gmail.com>
 <CACNYkD4G2Tr6=UE4pJgCCyqgooKQukWbD=cP1RVDmo-ptBb-4A@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CACNYkD4G2Tr6=UE4pJgCCyqgooKQukWbD=cP1RVDmo-ptBb-4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 15/02/2026 20:35, Muhammad Nuzaihan wrote:
> Hi All,
> 
> Work on MPTCP support for Firefox is completed and awaiting review.
> 
> https://bugzilla.mozilla.org/show_bug.cgi?id=1833182

Nice, thank you for having looked at this!

Current review comments seem positive so far.

  https://phabricator.services.mozilla.com/D283516

I will try to monitor that.
> However, this is an opt-in (disabled by default) and needs to be
> enabled in `about:config`

That's a good start! If the experiment goes well, this could be extended
later: either on by default, or only for some websites, or when there is
something written on the DNS or HTTP sides.

I just updated the "MPTCP ideas" spreadsheet:

https://docs.google.com/spreadsheets/d/1F2-v4Dhdn0rMyJZ3m5chyNiwg7oj0rpSR11GEykatJw/edit?usp=sharing

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

