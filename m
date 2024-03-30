Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77E881F;
	Sat, 30 Mar 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788123; cv=none; b=FkglQlH2w5CB9aEQOziSIaRuukZkJ8kuiJD1cbVcJ6XRUaR2BBe+axx2Jb9Rx++WgbV0T7dWnlXYUbYo9Q1mL1cxp3RubIo2akJ0Y21tc5PXe3pY1aqLyXzh/78xOGz5RR/qNJKw00tRL7NJTxMO3ENVYbEuT4APAvTVfMRXXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788123; c=relaxed/simple;
	bh=Ok2cDhfso4TDpA+Gl3lwSDvKxuJdbY8V+QMHG4GEcRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkXJxqj70x4kkwGkM1cBp13VsY14t9EuHK2Q25sKxl2zTHLCF/vVFdalOoQjZ59fQFfmiHQkq/J/iRWlYUIHkHZg5xIxmviW2iAAdAFO5h0AhjyILqPq365SmY1NupCOy6rWHDNYZMG58b3DlFrdWLXN4d9UzYVZyzknxGYRd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQmQB0og; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQmQB0og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B715C433C7;
	Sat, 30 Mar 2024 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711788122;
	bh=Ok2cDhfso4TDpA+Gl3lwSDvKxuJdbY8V+QMHG4GEcRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQmQB0ogLi04ukA/+Iw0RtIYKLwQsqkKQaDBR+XCR+qjkZbYZo5kCLihR3lwQRoXe
	 U4abKxmgZTbj7nVGMpDKPz1H8e+iicGyRhnUTRJselOb4VGUxjJZsDbOLMVabjZ2XT
	 r8Ej1aya/EdwfJHSBPEoPNVnS6uAiFh6vze3SWlE=
Date: Sat, 30 Mar 2024 09:41:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.15.y] selftests: mptcp: diag: return KSFT_FAIL not
 test_cnt
Message-ID: <2024033019-ice-ferry-0131@gregkh>
References: <2024032713-identity-slightly-586d@gregkh>
 <20240329145105.1637785-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329145105.1637785-2-matttbe@kernel.org>

On Fri, Mar 29, 2024 at 03:51:05PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The test counter 'test_cnt' should not be returned in diag.sh, e.g. what
> if only the 4th test fail? Will do 'exit 4' which is 'exit ${KSFT_SKIP}',
> the whole test will be marked as skipped instead of 'failed'!
> 
> So we should do ret=${KSFT_FAIL} instead.
> 
> Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
> Cc: stable@vger.kernel.org
> Fixes: 42fb6cddec3b ("selftests: mptcp: more stable diag tests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit 45bcc0346561daa3f59e19a753cc7f3e08e8dff1)
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - Conflicts in diag.sh because the commit ce9902573652 ("selftests:
>    mptcp: diag: format subtests results in TAP") is not in v5.15 tree.
>    These conflicts were in the context for an unrelated feature.
>  - Compared to the conflicts seen with the same patch in the v6.1 tree,
>    there was an extra one here in v5.15 because the commit f2ae0fa68e28
>    ("selftests/mptcp: add diag listen tests") is no the in this tree: it
>    moves the assignation of 'ret' in '__chk_nr()' under an extra check.
>    The conflict was easy to fix, simply by changing the value of 'ret'
>    from the previous location.

Both now queued up, thanks.

greg k-h
