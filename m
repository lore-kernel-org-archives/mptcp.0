Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BD4CB54;
	Mon,  4 Mar 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570521; cv=none; b=JBpoREonABp4NgD2nXhBe/VjbbTDZAiQytffBUf6kYmfJEGRxhb4K4VHRcSXr+z2ctKm6wU9O15HMRDb252jD7CaPsL3cPMgyKjvUH4k0iuyOCVB51bbQDOaifEHqdcTPfHG7txFu93R9gO9CWOwavB2pc7G6m2RqbpD+0oI5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570521; c=relaxed/simple;
	bh=fmV5vZJyxWLZdrIordLYYY83KF/D5z5Vuo51jxDtBHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNXPz2mg0eFZyTrgPP+ojRtYlprlMmX2+hWHuVbxHMymApujiJs3oP3+vZ/PvYAw1VqPaUEG2rfZUIMrbjCaIHvEKT7+zvLudu5vQE6OKaFSc5Q+DJxT975HD6mKAAi21Y5Wp6Ye9xtdRW7cLls+SFoDL/pQhXZ4jBfX3P9qiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RgHeewLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RgHeewLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD23C433F1;
	Mon,  4 Mar 2024 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709570521;
	bh=fmV5vZJyxWLZdrIordLYYY83KF/D5z5Vuo51jxDtBHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgHeewLSmfGFZGa32IxGds7r+a70q7sUkNaahuJjfVfSmG1d5dlmd2ez7FdwlFEHk
	 SG/QZP6uFX+mFOEAnAKr3CPFh9ZFrXPedImw1EIi8qWk4oPkPdmZjYTL3uCOF9lIAi
	 4viqNTak8L8mivQcvC6xKd4kVC81W+wW5J6d5v7U=
Date: Mon, 4 Mar 2024 17:41:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH 6.7.y 0/5] mptcp: dependences for "selftests: mptcp: rm
 subflow with v4/v4mapped addr"
Message-ID: <2024030441-uncolored-faceted-0782@gregkh>
References: <2024030420-swimsuit-antacid-a0dd@gregkh>
 <20240304133827.1989736-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304133827.1989736-7-matttbe@kernel.org>

On Mon, Mar 04, 2024 at 02:38:28PM +0100, Matthieu Baerts (NGI0) wrote:
> Hi Greg,
> 
> To be able to apply the last patch without conflicts in v6.7, 4 other
> clean-up patches are needed.

6.6 and 6.7 patches now queued up, thanks!

greg k-h
