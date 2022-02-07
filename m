Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2861E2C9C
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 19:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644263344; x=1675799344;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=E0Jn7HaUwbgzveQICXfuDI8lTDvsrqEEfbddwItblKo=;
  b=hw43yzf6MOLMeH09NBjfcv2/q8yxW5UFINO9DvZS+eqnNqRIwD28Ha3x
   Vv5r3tHu9cDfCTDkbmzcz7usXbghMY6GDKh3L9K1nb2t2PTEXwoL5+u9L
   Uia+8pQEHQgI0OCDjuaJzJyULvo5wxxfSbvocB7OePNgXLKCPeNbgVMq9
   0qmM542dZH2n6lcRhW6VGWzzMY9gzQw375tQEmn7It3YvElhetyH1703F
   OvT3VYs44MIsrxo8BrwiBX1skoaygrXJ6W3Xs/Ad6ZyWLoyeqH438S7sE
   9wNDR+ms49CfaiCg/LTiFkyD04ROCbwjtFZL3SKbc6zanHnb3rmwuQp0f
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="309540692"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="309540692"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 11:49:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="772893577"
Received: from ngoyal-mobl1.amr.corp.intel.com ([10.251.4.190])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 11:49:03 -0800
Date: Mon, 7 Feb 2022 11:49:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: increase timeout to 1
 hour
In-Reply-To: <20220207100022.3936015-1-matthieu.baerts@tessares.net>
Message-ID: <4fc5f913-3a8-38a0-7898-8949472c83ec@linux.intel.com>
References: <20220207100022.3936015-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 7 Feb 2022, Matthieu Baerts wrote:

> With the increase number of tests, on a slow public CI with kernel debug
> settings, it has been observed it can easily and regularly take up to 45
> minutes to execute all tests in this very slow environment. The slowest
> test, mptcp_join.sh takes ~30 minutes in this case.
>
> In such environments, the selftests timeout set in the 'settings' file
> is disabled. But because other similar environments can be used to run
> MPTCP selftests, it is certainly better to increase the timeout for
> everybody else to 1h.
>
> Most of the time, running all MPTCP selftests takes around 5 to 10
> minutes on decent environments and the slowest test takes less than 10
> minutes, the current timeout.
>
> The timeout could be disabled but it is always good to have an extra
> safeguard, just in case.
>

I agree that it's good to have some timeout in place for our tests. An 
hour seems like a lot, has there been any feedback from others with CI as 
slow as ours?

The largest existing selftest timeout is 1500 (net/settings), and looking 
at the kbuild logs it takes their infrastructure 28 minutes to run the net 
tests and 11 minutes to run the MPTCP tests. What do you think about 
a smaller timeout increase for the MPTCP tests?

-Mat

> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    On my CI at Tessares, another machine is now used with a different host
>    kernel. mptcp_join.sh selftest is now regularly taking more than 10
>    minutes when testing with a debug kernel.
>
> tools/testing/selftests/net/mptcp/settings | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/selftests/net/mptcp/settings
> index a62d2fa1275c..ed8418e8217a 100644
> --- a/tools/testing/selftests/net/mptcp/settings
> +++ b/tools/testing/selftests/net/mptcp/settings
> @@ -1 +1 @@
> -timeout=600
> +timeout=3600
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
