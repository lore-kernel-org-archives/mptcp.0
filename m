Content-Type: multipart/mixed; boundary="===============9127604964102327882=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/4] Add REMOVE_ADDR support
Date: Tue, 11 Aug 2020 17:29:42 +0800
Message-ID: <20200811092942.GA11472@OptiPlex>
In-Reply-To: 20200810062456.GA19671@OptiPlex
X-Status: 
X-Keywords:                  
X-UID: 5531

--===============9127604964102327882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt, Paolo,

On Mon, Aug 10, 2020 at 02:24:56PM +0800, Geliang Tang wrote:
> Hi Matt, Paolo,
> =

> On Thu, Aug 06, 2020 at 08:33:04PM +0200, Matthieu Baerts wrote:
> > Hi Geliang, Paolo,
> > =

> > On 04/08/2020 12:01, Geliang Tang wrote:
> > > v5:
> > >   - merge mptcp_nl_remove_subflow() and mptcp_nl_remove_addr()
> > >   - add cond_resched
> > >   - reduce the indentation level in mptcp_pm_nl_rm_addr_received
> > > =

> > > v4:
> > >   - update mptcp_subflow_shutdown()'s args.
> > >   - add rm_id check to make sure we don't shutdown the first subflow.
> > >   - add conn_list empty check.
> > >   - move anno_list to mptcp_pm_data.
> > >   - add a new patch 'mptcp: add remove subflow support'.
> > > =

> > > v3:
> > >   - fix memory leak and lock issue in v2.
> > >   - drop alist in v2.
> > >   - fix mptcp_subflow_shutdown's arguments.
> > >   - bzero remote in mptcp_pm_create_subflow_or_signal_addr.
> > >   - add more commit message.
> > > =

> > > Geliang Tang (4):
> > >    mptcp: rename addr_signal and the related functions
> > >    mptcp: add the outgoing RM_ADDR support
> > >    mptcp: add the incoming RM_ADDR support
> > >    mptcp: remove addr and subflow in PM netlink
> > =

> > Thank you for the patches and the reviews!
> > =

> > I just added these patches except the last one in the "export" branch.
> > =

> > Tests are still green!
> >
> =

> Thanks for applying my patches. The last patch is still have a bug in
> it, sometimes it will trigger a deadlock. I'll try my best to fix this

Sorry, I made a mistake here. This is not a deadlock issue caused by the
last patch in my patchset v5. It's a NULL pointer panic. And this bug has
been fixed by Paolo's patch "mptcp: be careful on subflow creation".

So here I sent out a new version of my patchset, v6. In this new version,
I updated the patch as Paolo suggested. And I added the selttest test
case for the remove addr and subflow.

Thanks.
-Geliang

> bug. Then I'll send out the final version of the last patch.
> =

> Meanwhile, I'm writting the selttest test case for RM_ADDR. It's not
> finish yet. I'll send out the test patch recently.
> =

> -Geliang
> =

> > Cheers,
> > Matt
> > -- =

> > Tessares | Belgium | Hybrid Access Solutions
> > www.tessares.net
--===============9127604964102327882==--
