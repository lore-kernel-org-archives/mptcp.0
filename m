Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281E173
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 14:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73718C00446;
	Fri, 10 Dec 2021 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1639148078;
	bh=Q1K2S4f0nrxeNfaTP4vRuZ3EtV7zVYEqjCEZjFJRS+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Udr8ls2mK7w9ihkao+4Z5vWlqANlkOFX7qwKDb8sSPPTifcf4WXnu7Ymji57LKnjN
	 U3UwUDqO9gCgsxG4jYqnyQLvXIv1pvG5GpNGMd9zXq56usxfVC/5RvYot3V6Uc9aMn
	 C3N5UlzDdgqcA9pTTKq3mwFXnFF0Dm1rF0dlEz0rVIpuF8Wc4W575g9GyxHKeWOIHr
	 XC3l3Vlj6S2zbovSoGfdE+MqzYZKBO+DUTxzq/PC/RU4zhKMtRoVDzaQuy9O1kAWfu
	 o2QcVLR73Mmi1+XrtBs49ETohfnN9I3/e8rw3ynFcmQF/toY6TZKqu6m5/ZlgR9+UP
	 SXeEevHP+Yyeg==
Date: Fri, 10 Dec 2021 06:54:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: cgel.zte@gmail.com, mathew.j.martineau@linux.intel.com,
 davem@davemloft.net, shuah@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>, ZealRobot
 <zealci@zte.com.cn>
Subject: Re: [PATCH] selftests: mptcp: remove duplicate include in
 mptcp_inq.c
Message-ID: <20211210065437.27c8fe23@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <ab84ca1f-0f43-d50c-c272-81f64ee31ce8@tessares.net>
References: <20211210071424.425773-1-ye.guojin@zte.com.cn>
	<ab84ca1f-0f43-d50c-c272-81f64ee31ce8@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Dec 2021 10:58:27 +0100 Matthieu Baerts wrote:
> Hi Ye,
> 
> On 10/12/2021 08:14, cgel.zte@gmail.com wrote:
> > From: Ye Guojin <ye.guojin@zte.com.cn>
> > 
> > 'sys/ioctl.h' included in 'mptcp_inq.c' is duplicated.  
> 
> Good catch, the modification looks good to me:
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> 
> This patch is for "net-next" tree as it fixes an issue introduced by a
> patch only in this tree:
> 
> Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
> 
> Regarding the commit message, please next time include the Fixes tag and
> mention for which tree it is for in the FAQ [1], e.g. [PATCH net-next].
> 
> 
> @David/Jakub: do you prefer a v2 with these modifications or is it fine
> to apply this small patch directly in net-next tree?

v1 is fine. Let me apply it right away and do the edits before I forget
they are needed..
