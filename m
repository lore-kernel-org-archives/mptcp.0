Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73651756B;
	Mon,  4 Mar 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540316; cv=none; b=lnnrcrhWSjDgSZJ+jyl/prOTkx+KQYFj+Oehwd9g1srYW6O08ILLcSK1b22sGgPZZ/G04LveIzMr7RW5LBnJtfcY9/qofHiToqFjlh6QRliVIYP8t5uhrFUH2D/do8iaD3XxlLpVQbLHqeSPdT0fqnNZGl1vQQRHvSuDcf/WyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540316; c=relaxed/simple;
	bh=KTpJxqX4wza7/sdGCfEEBphndr8hF8PljR8y8ZzgInI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HedJdUj41SdcP0H9CtPVdbzRumojmGvAkIw1K8u35sPmcZLlk9wwTu3KwjlxxGfff0rnZXCFm683jcsNKPrJ0VOXuMgGK/g+jTaoEb3l+WomNFPTMgO0Q2dW0/Vs8BTjBd1swzrapTnZKSgEwDkZ4vYHQ7ThnAK3AIGKzpbDzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0UKgThL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0UKgThL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E67C43390;
	Mon,  4 Mar 2024 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540316;
	bh=KTpJxqX4wza7/sdGCfEEBphndr8hF8PljR8y8ZzgInI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0UKgThL6NV/LxCsBQQl/PaTAfhT5PVCjJ50G/EgG++bqGQV6P9YGVIkwmf6XXQLBX
	 zZc5ogyAcCl6Bbv44mSm0+pipaDlT7SUD8kq0E//0go+AOGqh3Aplrg8pRwczK4I9Y
	 OQujEjeVBEbKx8hiRYCryze+v8od38dYQmQZtI7M=
Date: Mon, 4 Mar 2024 09:18:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: matttbe@kernel.org, mptcp@lists.linux.dev, sashal@kernel.org
Cc: stable-commits@vger.kernel.org
Subject: Re: Patch "mptcp: continue marking the first subflow as UNCONNECTED"
 has been added to the 5.4-stable tree
Message-ID: <2024030419-surplus-delicacy-7788@gregkh>
References: <20240228172121.243458-2-matttbe@kernel.org>
 <2024030422-divinity-blimp-6559@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030422-divinity-blimp-6559@gregkh>

On Mon, Mar 04, 2024 at 09:11:22AM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     mptcp: continue marking the first subflow as UNCONNECTED
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Oops, nope, my fault, this doesn't go to 5.4.y, sorry for the noise.

greg k-h
