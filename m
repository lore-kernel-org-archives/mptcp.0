Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B61DA301;
	Wed,  4 Sep 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460430; cv=none; b=sfcy9nezmdj5w7e7vqr9NhtJmd9QvdRgq+CYbSzvzWV2DIFMCYNjLSxDaHrZ9nKs4jRJYvwNoR5A2LUkxHu4hMogE/3rsO79io6HGtcj/SQnEpOSQmsd45mxuwm2h710QRxWVdbJO/4HcPBoWV5I8lZOFHtAZpMIt/xyBS3GpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460430; c=relaxed/simple;
	bh=rVuaORk17sTnbnG8gdImMI5Om1MiiU8eKBa7r0w1qNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+dl35uBOD72+xwKFhSX6zdV9DUwhZSbc57vWZuM5jQMKxZr3f0dt272WoxPb2g7jkn++7sDho+eQ5DTrIfa7nHeOr7NCIOMifI572rV4+u2fYq9N9TqwuQezyuiUD9hej4mtED9Tef1nwMplULlECJMCREHqoJhuYer8ncngA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Do7OQI1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Do7OQI1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034CCC4CEC2;
	Wed,  4 Sep 2024 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460429;
	bh=rVuaORk17sTnbnG8gdImMI5Om1MiiU8eKBa7r0w1qNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Do7OQI1l1XtAcBejm9eIUruHfI/+aAHCPpoCOQFN35QwrnGlO0hCZ8hQ/lS0DBN9Q
	 ZmTEIurW6cTHv/hlMtyRNXoFvojKW1VxulQh2rGa9RXq98dGo0n5Hu3EidTM6okggx
	 XT4A8OGk7GfzSQs9cqI9ES5Y/veov8GXrOU6rbyM=
Date: Wed, 4 Sep 2024 16:33:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] selftests: mptcp: join: test for flush/re-add
 endpoints
Message-ID: <2024090414-richly-nearest-a619@gregkh>
References: <2024082618-wilt-deafness-0a89@gregkh>
 <20240904110611.4086328-3-matttbe@kernel.org>
 <20240904110611.4086328-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110611.4086328-4-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:06:13PM +0200, Matthieu Baerts (NGI0) wrote:
> commit e06959e9eebdfea4654390f53b65cff57691872e upstream.
> 

Applied
