Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537B36B
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 01:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646269714; x=1677805714;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AGGjAIIyDLHCdh/qKt5qlBAYQylVNS4D5i10J10+bXM=;
  b=kXt66hLVV+Ec2E7LOKuDuOVaLUq6km2k3AoZnEo++AOe95H3HRctTIjU
   jTgz55pTKNjVu866AvZKqUyvhc0fRCGG6zOjTRZKlS9/ZPbdrlkNu9Chb
   eRqJTjfFkOzZEMuvokPKtZXUxxhlFGuD9H8R3zr3ZEmg/CnRGQyF0I9nD
   mbaIDtrqn8SMac7u7uGxPqcmmQH+b2bo+QlRgiOuHQZu2ujxnY0qByJwk
   ijkdaYFH9q354Eq57g9Ho5UM4Isms81HEmunrW0aGUT59w30HvvcYmyZ6
   mh1r552X9bBkP7iAi8z616vhyK3nUPLzxqFZyTLxCRs30Y6vZxP/Y7k+g
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253474587"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253474587"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 17:08:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="493745788"
Received: from ashetty-mobl1.amr.corp.intel.com ([10.209.74.124])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 17:08:33 -0800
Date: Wed, 2 Mar 2022 17:08:33 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [RFC PATCH mptcp-next 0/4] MP_JOIN fallback for TCP listeners
In-Reply-To: <3c10ce87c885ade73b3fe8dc086569233250684d.camel@redhat.com>
Message-ID: <8962318e-3e7-7da4-6c90-b2373260997@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com> <3c10ce87c885ade73b3fe8dc086569233250684d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 25 Feb 2022, Paolo Abeni wrote:

> On Thu, 2022-02-24 at 15:22 -0800, Mat Martineau wrote:
>> Compared to Florian's proposal (add token lookup before the listener
>> lookup) this does change more lines of TCP code, but has less runtime
>> impact.
>
> I think this will need more changes to TCP code, see my reply to patch
> 4/4.
>
> I really don't know which one will affect plain TCP setup more from
> performance PoV: we will have a token lookup for each incoming syn
> packet with both impl.

This proposal has less runtime impact on plain TCP. It uses the existing 
TCP option parsing pass in tcp_check_req(), and adds one conditional 
that's looking at the new saw_mp_join bit that was possibly set when 
parsing options.

Florian's "mptcp: handle join requests early" is a smaller change to the 
TCP code, but adds an extra function call and a new TCP option parsing 
pass for every incoming SYN. Since the MP_JOIN option will not typically 
be present, it doesn't look like there are many extra CPU cycles other 
than that option parsing pass.

> With this patch we still need "mptcp: replace
> per-addr listener sockets", right? otherwise issues/203 will not be
> addressed.

Right.

>
> The thing that concerns me more is that this approach brings quite a
> bit of MTPCP logic inside the TCP code with little/no isolation.
>

If there's enough interest for a RFC v2 I could refactor with some new 
mptcp helpers.

> More I think about it and more I belive we will should try to code as
> simple as possible. And the easyest way to address issues/203 is
> possibly at the documentation level...
>

There seems to be enough benefit to socket users to justify some amount of 
code change to avoid confusing and hard-to-troubleshoot behavior. I still 
lean toward making it work better, and acknowledge the need for better 
docs no matter the solution :)

--
Mat Martineau
Intel
