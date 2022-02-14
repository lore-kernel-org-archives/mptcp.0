Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BCC8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644871924; x=1676407924;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Otpj6iRahyCWxcyP8DcDkG2SlmbnaZKnYbK1h6mXQzw=;
  b=RdWYy4a+ewqIJfNjJQs5ZRKYRNl+YyZcMUGhn5FUQ2WDjcCOekxwfad4
   BZncefbTMNjaWuaAV7q/JmQ8e1uH1TNwzQAObNHJqDHHULg3/8TxtLiXU
   P1jZZKaTjTiCa6wM65KL/P70bCup7obkyxXc35xbgydAom3JcKKp93+km
   IBOMflNZ/8V/H48et7JI0GkP83zS0mMJQq1BubhIp1D1QlbsaP4LxG2/o
   hTNfm+IR51xNqEoTyyfYZdpWSLIy/7re8uloxj+ruEGNim+GAoZr0CLYA
   gtqA6uiQFzBmB8cfoRNpo6r1FMU48FbpVwgeNJNkNWI4oWRBeNmQMp19B
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249013374"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249013374"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:52:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="773227355"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:52:03 -0800
Date: Mon, 14 Feb 2022 12:52:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Ivan Bornyakov <i.bornyakov@metrotek.ru>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: fpga: microsemi-spi: add Microsemi FPGA manager: Build Failure
In-Reply-To: <4c8487e0-fef3-a905-843d-99828ad4bed7@gmail.com>
Message-ID: <a18f5bf4-99b6-522-32f-99bd26c93ede@linux.intel.com>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru> <4c8487e0-fef3-a905-843d-99828ad4bed7@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Feb 2022, MPTCP CI wrote:

> Hi Ivan,
>
> Thank you for your modifications, that's great!
>
> But sadly, our CI spotted some issues with it when trying to build it.
>
> You can find more details there:
>
>  https://patchwork.kernel.org/project/mptcp/patch/20220214133835.25097-1-i.bornyakov@metrotek.ru/
>  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843014032
>
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6087ab4681ee
>

Ivan,

Sorry about the unexpected email from our CI system. It appears there was 
an issue with patchew.org that somehow applied and tagged your patch in 
our github repo even though you didn't send to our mailing list, which 
triggered an automated build.

--
Mat Martineau
Intel
