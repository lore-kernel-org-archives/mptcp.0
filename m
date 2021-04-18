Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DF2F83
	for <mptcp@lists.linux.dev>; Sun, 18 Apr 2021 19:41:37 +0000 (UTC)
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13IJfBoh013865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Apr 2021 15:41:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4290B15C3B0D; Sun, 18 Apr 2021 15:41:11 -0400 (EDT)
Date: Sun, 18 Apr 2021 15:41:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, linux-ext4@vger.kernel.org,
        netdev@vger.kernel.org, rafael@kernel.org, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, mathew.j.martineau@linux.intel.com,
        davem@davemloft.net, broonie@kernel.org, davidgow@google.com,
        skhan@linuxfoundation.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 3/6] kunit: ext4: adhear to KUNIT formatting standard
Message-ID: <YHyLV1SVfGVLRG2+@mit.edu>
References: <cover.1618388989.git.npache@redhat.com>
 <cbc925da29648e3c9fa6d0945331914911ab6d40.1618388989.git.npache@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc925da29648e3c9fa6d0945331914911ab6d40.1618388989.git.npache@redhat.com>

On Wed, Apr 14, 2021 at 04:58:06AM -0400, Nico Pache wrote:
> Drop 'S' from end of CONFIG_EXT4_KUNIT_TESTS inorder to adhear to the KUNIT
> *_KUNIT_TEST config name format.

Another spelling nit, that should be "in order".

This will break people who have existing .kunitconfig files, but if we
are going to make this a standard (but please document it as a
standard first!), might as well do it sooner rather than later.

Cheers,

							- Ted
