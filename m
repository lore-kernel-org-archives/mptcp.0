Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE72FB8
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 23:24:51 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6EEEA21A67;
	Tue, 15 Jun 2021 23:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1623799484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjOO2Dmo42mlJGOoHwQtbKYRUCAg4xIkjWwEosdAdu0=;
	b=RLBDSVlfP1f0KZ/YzyIL42L4a77lKFcdQEFvG6BYlPDUey7LQgOj92IK0aiUxi8KMCE1lo
	aj/ux2Aa4sBCNSa2mhGwciOVG5vu8Jqyx+oAT+2yoJiqFUiwXxK25/625KVtJ1i1MABjVZ
	nFnk6Z2UaY2f/DwLrIMoxyw+DvTJ5Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1623799484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjOO2Dmo42mlJGOoHwQtbKYRUCAg4xIkjWwEosdAdu0=;
	b=iFN/JuUES9mxE9eip7VFAzmnkN2rqZRAdCpAIwlpYD/lFmlic2qPjlWfQhF+L81n1Xauyo
	sZGmXvxvmiOXOFDQ==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 1C375A3B8A;
	Tue, 15 Jun 2021 23:24:44 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id DBA15607D8; Wed, 16 Jun 2021 01:24:43 +0200 (CEST)
Date: Wed, 16 Jun 2021 01:24:43 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Rui Sousa <rui.sousa@nxp.com>,
	Sebastien Laveze <sebastien.laveze@nxp.com>
Subject: Re: [net-next, v3, 05/10] ethtool: add a new command for getting PHC
 virtual clocks
Message-ID: <20210615232443.itunrkhaiy7h5gty@lion.mk-sys.cz>
References: <20210615094517.48752-1-yangbo.lu@nxp.com>
 <20210615094517.48752-6-yangbo.lu@nxp.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615094517.48752-6-yangbo.lu@nxp.com>

On Tue, Jun 15, 2021 at 05:45:12PM +0800, Yangbo Lu wrote:
> Add an interface for getting PHC (PTP Hardware Clock)
> virtual clocks, which are based on PHC physical clock
> providing hardware timestamp to network packets.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v3:
> 	- Added this patch.
> ---
>  include/linux/ethtool.h              |  2 +
>  include/uapi/linux/ethtool.h         | 14 +++++
>  include/uapi/linux/ethtool_netlink.h | 15 +++++
>  net/ethtool/Makefile                 |  2 +-
>  net/ethtool/common.c                 | 23 ++++++++
>  net/ethtool/common.h                 |  2 +
>  net/ethtool/ioctl.c                  | 27 +++++++++
>  net/ethtool/netlink.c                | 10 ++++
>  net/ethtool/netlink.h                |  2 +
>  net/ethtool/phc_vclocks.c            | 86 ++++++++++++++++++++++++++++
>  10 files changed, 182 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethtool/phc_vclocks.c

When updating the ethtool netlink API, please update also its
documentation in Documentation/networking/ethtool-netlink.rst

Michal
