Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0963C2B;
	Thu, 22 Jun 2023 05:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB517C433C0;
	Thu, 22 Jun 2023 05:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687413100;
	bh=NTX7VWfLGARQLJisvkuE+QEyr+YuxA7almFhy0ABrCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDcVXhCvSdfvn0Wr5RULHFSTqbKzV7odP/DcQtdYc10orLyvIyfNmL/DlTaFFA5OT
	 Y8ovDN/Q+wEfXae+H8Rm7UbEK/HUk7T4CATn1+0Wuql2CSdY/IbD8rd6jtpz/DwgfQ
	 HmMmlWjW1O8EytfJUZkZADOpRY5G1KlF3FBE6z6SnelHQQYSy6paQqz5/JOo9urFT/
	 VUJX1EBhovNz9kDUhhHpvQCt7CJJp2uaWpnK9kHxzs+I8Aj3NbXhlUBxnw5O9yEVY6
	 oqhuV9JGcSHY6Qu4syQnDYapDqUAqCfR2VEGxsyXl6fwrelDvmQbI1nD0G8yciIFJA
	 Z9eltykgdREwA==
Date: Wed, 21 Jun 2023 22:51:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/9] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Message-ID: <20230621225138.320b01f1@kernel.org>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-5-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
	<20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-5-62b9444bfd48@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 18:30:18 +0200 Matthieu Baerts wrote:
> information all-at-once (everything, everywhere...)

;]
