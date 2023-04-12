Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A45698
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 14:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02C0C433D2;
	Wed, 12 Apr 2023 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681309098;
	bh=6Z0pbvNmrmVKo0gV14o7boQwibOZ6zoml5KjVPBYbrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jWcAfFDi1yErfUL9gWWMQQrSZKXusEk4CciyMQvlEKFuY/pEfPQOIR3tcArnXYwae
	 xmcKpSS9vSVAoSoGvqaQjoPc0zMyhHK4SBD1Oc36usYNsdCtDSRLKJOGsGCH+3ElNw
	 N4OuMv/ZyG1QHQ20ppy6ABY2bDkLCCUZfvkTkwitrX1x25WVkcwsBOpCGOQE9qgMtT
	 W8JCIxJpZ+daZwEX9AsCxtUqzsj/SdktRpQoodN/KoAvl7KHYOryxl8wErE2z74DoD
	 DpAMrzAgq4rd4CvdpXTM5TXXjhXdp9Tsz+snM9UNZqHW84qiJxyElIwW6rkjaTW8Xu
	 7OZdWdk3Y8dGw==
Date: Wed, 12 Apr 2023 07:18:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev
Subject: Re: [PATCH net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
 IPPROTO_UAPI_MAX
Message-ID: <20230412071816.0c0898ee@kernel.org>
In-Reply-To: <20230406092558.459491-1-pablo@netfilter.org>
References: <20230406092558.459491-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Apr 2023 11:25:58 +0200 Pablo Neira Ayuso wrote:
>    IPPROTO_RAW = 255,		/* Raw IP packets			*/
> +  IPPROTO_MAX,
>  #define IPPROTO_RAW	

nit: any reason the IPPROTO_MAX is in between the enum entry 
and its associated define?
