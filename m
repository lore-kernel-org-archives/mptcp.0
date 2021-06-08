Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD12FAD
	for <mptcp@lists.linux.dev>; Tue,  8 Jun 2021 08:58:51 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id ce15so31369180ejb.4
        for <mptcp@lists.linux.dev>; Tue, 08 Jun 2021 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R132Ar5Zepsar6hohonDBlGNgEKmfUNLhTgz18MBQpA=;
        b=jUq3YMTxAuzUVuZu/9lnABLZ29qXb6QRShVZKGLij2tdNLC0Uav03FwJC8bBFITnCA
         nMoeSx+AjRPv3dSAVqqEszvc5KeswtiQDvuhnWNvOVD/aGeQ5BjWTyXV/UjbV0Se8ESo
         aIQPY7EqS03yRZVrWiYX2yNp1fquVtLt46tMvOR1/allzzyu0w9bP5Zz7ida7co0r3I0
         /SZBeUHSSUy3v8UoaKvAvq7scX7oKH2coix670+i76WH+S/MMPF2Q0LLiBughqnNgNQ3
         5AHIsTGY0/K2N3PEe1PdNXmJsMcGXYxL3I6roU0p388a4wVxxzlkRzV4R1W04DnIqHFd
         Xpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R132Ar5Zepsar6hohonDBlGNgEKmfUNLhTgz18MBQpA=;
        b=nRW9regWtP6l9oj+inHCA52AJT025fA/ORxgYbGfblqDtsGTITZOhH5pd8S8CENJui
         rrEZaUPTqZAKltKg696sJDY8x2bOL9oIi0RJXOBhgVIpMswkBsLdnp5g/vfg4f6TGr2r
         E37iPgnCg7/9bhYEB1cKETHnM0zrL7cCtv2I/0JZDWcAWNdPSuZ7zOYREWaWICKmvxmv
         8OvNydkUSJARjPcd799Ic0WbWllT1TH7OMKzleNJqpiYA6K1ySTMTkXJgOMsXznLmgx3
         OlekjX7QDPEbgPv8gbp6nmzPSVIVw/XpphUaxODMJIc9Sd3G8zSMfiMcDn+4GfTj0w2Z
         vsGw==
X-Gm-Message-State: AOAM533ZK4h9yyNpirgtr/kEdafR9fFe456CrFw0ScJ6azaOEdPiiWph
	ywGmvaRRddFeX72zGBnc2PBSAyzc3rQecAm25FA=
X-Google-Smtp-Source: ABdhPJw1Q4Qq7ut0g+1NMff0cFLBJ6AKKBWDC6Qb9SPbv3N0pQozNwlLg+smjvJS1mP2LP+lePk4BA==
X-Received: by 2002:a17:906:b213:: with SMTP id p19mr14599866ejz.51.1623142729999;
        Tue, 08 Jun 2021 01:58:49 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:fc48:eb4c:7e84:e1ff])
        by smtp.gmail.com with ESMTPSA id da28sm1455970edb.69.2021.06.08.01.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 01:58:49 -0700 (PDT)
To: David Candal Ventureira <dcandal@gti.uvigo.es>
References: <CAEE33hBe_uiaB3nmjwaZQq7eKfY19z2R02fe2aj6at8wwTXKCw@mail.gmail.com>
Cc: mptcp-dev@listes.uclouvain.be, MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [mptcp-dev] MPTCPv1 test using multiple interfaces
Message-ID: <50bb1b1b-5bfb-34d5-e54f-ba41ac55e2fd@tessares.net>
Date: Tue, 8 Jun 2021 10:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAEE33hBe_uiaB3nmjwaZQq7eKfY19z2R02fe2aj6at8wwTXKCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi David,

+cc MPTCP Upstream ML

On 08/06/2021 10:14, David Candal Ventureira wrote:
> I'm interested in testing MPTCP for research purposes. I would like to
> build a simple set up with two computers exchanging traffic through two
> interfaces simultaneously.
> 
> For this, I deployed two virtual machines running Ubuntu 20.04
> 5.8.0-53-generic, as this kernel seems to support MPTCPv1 by default. In
> fact, I was able to exchange a file between the two VMs through MPTCP by
> using the code in tools/testing/selftests/net/mptcp. However, with this
> setup only one interface is used to transmit the traffic.

There are currently 2 different Linux kernel implementations: a fork
(out-of-tree) and a (in progress) rewrite version now in the mainline
Linux kernel:


https://github.com/multipath-tcp/mptcp_net-next/wiki#upstream-vs-out-of-tree-implementations

mptcp-dev ML is dedicated to the out-of-tree kernel.


> After seen Multipath TCP part 3: Multiple subflows and path management
> (https://lwn.net/Articles/816144/),
> I suppose that multipath support is not available yet in current kernels
> and I should compile the kernel
> in https://github.com/multipath-tcp/mptcp_net-next
> so that I could make use of this capability. Am I right?

With the 5.8 kernel, you can create multiple subflows but use each of
them one at a time. You might at least use the 5.12.

If you are interested by MPTCP, probably best to build the latest
version from Git. As an alternative, you can also find already built
packages for your distribution, e.g.

  https://kernel.ubuntu.com/~kernel-ppa/mainline/

> On the other hand, is there any tutorial regarding how to configure
> multipath? Is it possible to configure in any way how the traffic is
> distributed among the interfaces, instead of evenly distributing it
> through them, either in a dynamic or static way?

The out-of-tree implementation is still more flexible so far and
documented on:

  https://multipath-tcp.org/

But because the development is much more active on the upstream version,
it also makes sense to look at it, report issues, ideas and patches ;)

Regarding the configuration, the path manager can be controlled with a
recent version of IPRoute and its 'ip mptcp' command:

  https://man7.org/linux/man-pages/man8/ip-mptcp.8.html

But any tutorial would be really welcome!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
