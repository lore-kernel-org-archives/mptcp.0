Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077E205E2E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494911; cv=none; b=am4kxAkgdkX2xz4O/trjNV4n77J8M/eRroDN0vrHc9xLyZtQv98buzxQYadWHnwZStPeeTAJd2TBGgVFK2EJr7NyFfUpeTt1rycCkX/x8SQbU12RoK6JutkhXh5diId01vhYX/btE7NwyFwvBam6MHKYpzoe1l0DCdR5FDzJDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494911; c=relaxed/simple;
	bh=wJa3dBsSNzJHrzQnwQmV6m+XZfHKmlHrUGXbEao6PNQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Qsdanz8vCG19k6z/Z5cEUQQiyMuNrrqYayYxZJFY9y+vtWppdx9TLBgAutKn3z2UVLAYcEONMyhjSSfDxIrPT6SYGpQ6KW+D4F1IQxAHJzWxQ3E6DMOxx9v9XrdosvxC539kZh52KlTso9brMipTYhc2MB48JG+AEhi8Uxn+iTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb1PZ/IC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb1PZ/IC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A72C4CED6;
	Fri, 10 Jan 2025 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494911;
	bh=wJa3dBsSNzJHrzQnwQmV6m+XZfHKmlHrUGXbEao6PNQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Eb1PZ/ICJ0dfDnoCxccZotOdwae6FtAmJLRsBuhRoMgC0mn1YimX+3YtZpyAShN0e
	 O+N9DgWpnsXEk3iNhdmLJl1HBjnmPttcRbXaTbQ/72RzYN0K3n7Es06RhFv+IGj817
	 b+MXZZrKZ3RJP6otRPDCmaBqTD/I1J9i0kc6W1Gs0+/jdPP9gaR1c9cdmPRWXgD/BB
	 xXILN07ebNWk4S26E/XtCv1ZfqgfGNoDFHOIHK4aPMdg391n+eIAOwN2+3TtqNtsMF
	 zU5P4/rVrdvQaJKmoOuuQ6wP3/fGhI+EXWBzbTpApWpOCnavQL9nxEuAfeKgF+GI1T
	 14G/X0Vbufwxw==
Date: Fri, 10 Jan 2025 08:41:45 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Message-ID: <b6165440-f421-42a7-bc8d-e8e8bcaeb69a@kernel.org>
In-Reply-To: <ff9a10bb4359ec77fc0b7499f44b388d737abe0f.1736477907.git.tanggeliang@kylinos.cn>
References: <5ff48cd1eed9a8b4c51a9ba5d7f9e0d0e8b0389b.1736477880.git.tanggeliang@kylinos.cn> <ff9a10bb4359ec77fc0b7499f44b388d737abe0f.1736477907.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: move stats info
 in case of errors to lib.sh"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <b6165440-f421-42a7-bc8d-e8e8bcaeb69a@kernel.org>

Hi Geliang,

10 Jan 2025 04:02:53 Geliang Tang <geliang@kernel.org>:

> Drop the last two arguments "lstat" and "cstat" of mptcp_lib_pr_err_stats.

I think it might be better to keep these arguments, not to have the lib assuming the files will be located there, e.g. just in case we move them elsewhere later, to be clear that when reading the code in the tests that these files will be used there, etc. no?

Cheers,
Matt
