Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329D13AF4
	for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 09:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177CAC433C7;
	Tue, 12 Sep 2023 09:52:45 +0000 (UTC)
Date: Tue, 12 Sep 2023 10:52:43 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZQA064908T5nngcc@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>
 <ZPi1LvrcGcSKBLqR@arm.com>
 <CAEXW_YTxLRAKCpFdKOdegj0gZdBb0OH+BnJf9FGTGfPtwiPkiw@mail.gmail.com>
 <26A7E7B0-8B40-465C-9FC6-6F3D6529A591@apple.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26A7E7B0-8B40-465C-9FC6-6F3D6529A591@apple.com>

On Mon, Sep 11, 2023 at 10:41:15AM -0700, Christoph Paasch wrote:
> On Sep 10, 2023, at 4:10 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Wed, Sep 6, 2023 at 1:21 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Tue, Sep 05, 2023 at 02:22:13PM -0700, Christoph Paasch wrote:
> > [..]
> >>> If you have an updated patch, let me know. I can test it.
> >> 
> >> I sent it in reply to Joel.
> > 
> > Just checking if you got a chance to try Catalin's patch?
> 
> sorry for the delay! Yes, I tested it and it works!

Great, thanks!

-- 
Catalin
