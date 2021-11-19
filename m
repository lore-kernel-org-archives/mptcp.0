Received: from mail.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C368
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 15:46:38 +0000 (UTC)
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
	by mail.monkeyblade.net (Postfix) with ESMTPSA id 131A54D2DC50A;
	Fri, 19 Nov 2021 07:46:29 -0800 (PST)
Date: Fri, 19 Nov 2021 15:46:24 +0000 (GMT)
Message-Id: <20211119.154624.385742174897604212.davem@davemloft.net>
To: pabeni@redhat.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, edumazet@google.com
Subject: Re: [PATCH net 0/2] mptcp: fix 3rd ack rtx timer
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1637331462.git.pabeni@redhat.com>
References: <cover.1637331462.git.pabeni@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 27.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 19 Nov 2021 07:46:31 -0800 (PST)

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 19 Nov 2021 15:27:53 +0100

> Eric noted that the MPTCP code do the wrong thing to schedule
> the MPJ 3rd ack timer. He also provided a patch to address the
> issues (patch 1/2).
> 
> To fix for good the MPJ 3rd ack retransmission timer, we additionally
> need to set it after the current ack is transmitted (patch 2/2)
> 
> Note that the bug went unnotice so far because all the related
> tests required some running data transfer, and that causes
> MPTCP-level ack even on the opening MPJ subflow. We now have
> explicit packet drill coverage for this code path.

Acked-by: David S. Miller <davem@davemloft.net>
