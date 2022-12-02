Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AA7C
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 04:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4B1C433D6;
	Fri,  2 Dec 2022 04:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669953936;
	bh=eQduLD1CaQJBrT16fPY+PEEtH9DVBuaJ5vuTkbvSwLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LfJwcjSBZ+d5QuNRXGHPmFKWG5HONHQmPePDHYer4pmeUtEP/tnWnPpnWE7bpqVaB
	 dtvqeK5E9tivaM6NhbwT6TnOZ45aYNMznwBl7CgEW3vl4BdoXyvIfragX9fu2vu7U0
	 o5cAWqu/xn9kRocnRLcSmCqo3okpQikValkI6LX9oijsvgASs2ftA21smjKRfoR3mO
	 ZwBRdjQ9/8iMf8BerSFBrqbk5A4/CcFOrWheVTTTojN7VHhOZ9VWGOcbQqXcsNcmYw
	 BdNrPAeYKelsyBz6FMIrpPAU8PQrOCLcdpebBL5j+dyC4dYta25ZQpUzgOqRzB9n5X
	 e2mnkJvwhw7PQ==
Date: Thu, 1 Dec 2022 20:05:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/11] mptcp: add pm listener events
Message-ID: <20221201200535.14e208ac@kernel.org>
In-Reply-To: <20221130140637.409926-7-matthieu.baerts@tessares.net>
References: <20221130140637.409926-1-matthieu.baerts@tessares.net>
	<20221130140637.409926-7-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Nov 2022 15:06:28 +0100 Matthieu Baerts wrote:
> +	kfree_skb(skb);

nlmsg_free(), could you inspect the code and follow up?
