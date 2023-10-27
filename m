Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987F1F5E7;
	Fri, 27 Oct 2023 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhx7P01j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C853C433C8;
	Fri, 27 Oct 2023 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698420868;
	bh=ziq56SQjqCXwbQsOXsErLai1hrp9esUNrbmuffoh6/o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hhx7P01jQGkf2otnocV8FyG8g3d3v/DACsuNBgiG98xqnbkJURasskiAp61mV2Mzv
	 Er/fXd/Svx6wdrt/sN2v1XfMac+e3umUgdc0BUtLxi+dB/Ze0JyrFY9k5rUw2DRCG3
	 i730iioahZSWJxoPpcQuNieuru5tYyyp7T4EMelGx9V1HIfyqmwXu4AXL3tTtIbwcn
	 RH2QgmofVFr0V+5fdkjGBOar9XhYMN0fZMDKcQ0rKIqZEe7F1kIw5IMlGZaazv+B8S
	 z0pFF5F7ZyiSSdoU3aspBjsAwTHBiLo2RfVdK1Up2TX+wXwIExRkBTW0sTOUcGJbPo
	 tlRAZFT2MrGtw==
Date: Fri, 27 Oct 2023 08:34:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
cc: Matthieu Baerts <matttbe@kernel.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Geliang Tang <geliang.tang@suse.com>, 
    Kishen Maloor <kishen.maloor@intel.com>, netdev@vger.kernel.org, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: userspace pm send RM_ADDR for ID
 0
In-Reply-To: <20231026202629.07ecc7a7@kernel.org>
Message-ID: <aa71b888-e55b-a57d-28cc-f1a583e615f9@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org> <20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org> <20231026202629.07ecc7a7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 26 Oct 2023, Jakub Kicinski wrote:

> On Wed, 25 Oct 2023 16:37:04 -0700 Mat Martineau wrote:
>> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>> Cc: stable@vger.kernel.org
>
> CC: stable@ + net-next really doesn't make sense.
> Either it's important or it's not. Which one do you pick?
>

Hi Jakub -

This is what I was attempting to explain in the cover letter:

> This series includes three initial patches that we had queued in our 
> mptcp-net branch, but given the likely timing of net/net-next syncs this 
> week, the need to avoid introducing branch conflicts, and another batch 
> of net-next patches pending in the mptcp tree, the most practical route 
> is to send everything for net-next.

So, that's the reasoning, but I'll send v2 without the cc's.


- Mat

