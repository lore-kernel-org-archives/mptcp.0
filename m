Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DD33F6
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 23:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651621623; x=1683157623;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N/FoYF53sRSv/lgFnebQ4LIawaYh1WFse9ZT+9n5RhU=;
  b=gDS8hudxxVznDjaf8XEOoWdhUyv8J4wzBRtCGX6Ei0WjNHEmYKPYNzt+
   qnHRgEjz7WkNmLj0u7bPK9ZMuGXzaUws68eXWomtVNAwFQXjS5Dswi73c
   WONmxu1INDabIMUBkiLszWtfXCWvoX9DhWxHaD7Tt+JYlnTeeO34GGv7E
   RByud6A2Vthb7+9WCQRnN3nWh4YSdmgO7PWXXzyRN0G9vKCSXYWeU3+In
   fc9P/wQ4JwEFwV8TULCnIE8ZqUGsImN7RWlJDP92C2/CCgadbAN1yYYdo
   FW9zN/sej3l7XCPPenfgPb0tsvhSv8BqKH6kGX2Hke6tDgSSxiBSSVvel
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249602179"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="249602179"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 16:47:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584434297"
Received: from skarmaka-mobl2.amr.corp.intel.com ([10.209.21.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 16:47:03 -0700
Date: Tue, 3 May 2022 16:47:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Maxim Galaganov <max@internet.ru>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, 
    Geliang Tang <geliang.tang@suse.com>
Subject: Re: apropos
 https://github.com/multipath-tcp/mptcp_net-next/issues/265
In-Reply-To: <c1513b33-add8-3e16-d14d-0b1886061040@internet.ru>
Message-ID: <db5294c-68db-d77d-8e5f-cd20a773634@linux.intel.com>
References: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com> <c1513b33-add8-3e16-d14d-0b1886061040@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 3 May 2022, Maxim Galaganov wrote:

> On 29.04.2022 13:08, Paolo Abeni wrote:
>> I think should see sistematic csum failure when the involved peers have
>> different endianess (e.g. x86 vs arm). If anyone has easy access to
>> both systems, could please verify the above?
>> 
>
> I've built OpenWrt from current master (4509b79) for ath79/generic with 
> CONFIG_TESTING_KERNEL=y
> CONFIG_MPTCP=y
> CONFIG_MPTCP_IPV6=y
>
> and flashed it onto TP-Link Archer C7 v5.
> This is what I can observe with a simple echo server and nc.
>
> Client:
> % uname -r
> 5.17.4-200.fc35.x86_64
> % lscpu |fgrep ndian
> Byte Order:                      Little Endian
> % mptcpize run nc 192.168.2.1 12345
> qwerty
> Ncat: Connection reset by peer.
>
> Server:
> root@tpa3:~# uname -r
> 5.15.35
> root@tpa3:~# lscpu |fgrep ndian
> Byte Order:          Big Endian
> root@tpa3:~# sysctl -w net.mptcp.checksum_enabled=1
> net.mptcp.checksum_enabled = 1
> root@tpa3:~# ./echo 12345
> Server is listening on 12345
> ^C
> root@tpa3:~# nstat 'Mptcp*'
> #kernel
> MPTcpExtMPCapableSYNRX          1                  0.0
> MPTcpExtMPCapableACKRX          1                  0.0
> MPTcpExtDataCsumErr             1                  0.0
> MPTcpExtMPFailTx                1                  0.0
>
> The issue goes away when I set net.mptcp.checksum_enabled=0 on both ends. 
> Please tell me if you need more info.
>

Hi Maxim -

Thanks for verifying the problem and that it does appear to interop when 
checksums are off.

I found some helpful notes from the BPF maintainers on setting up a 
big-endian s390x qemu guest:

https://www.kernel.org/doc/html/latest/bpf/s390.html

Hopefully that will allow us to set up some vms for ongoing testing. I'm 
working on setting one up to experiment with.

--
Mat Martineau
Intel
